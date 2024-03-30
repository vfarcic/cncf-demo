#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'This script assumes that you jumped straight into this chapter.
If that is not the case (if you are continuing from the previous
chapter), please answer with "No" when asked whether you are
ready to start.'

gum confirm '
Are you ready to start?
Select "Yes" only if you did NOT follow the story from the start (if you jumped straight into this chapter).
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|gitHub CLI      |Yes                  |'https://cli.github.com/'                          |
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
|Google Cloud CLI|If using Google Cloud|'https://cloud.google.com/sdk/docs/install'        |
|AWS CLI         |If using AWS         |'https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html'|
|eksctl          |If using AWS         |'https://eksctl.io/installation/'                  |
|az              |If using Azure       |'https://learn.microsoft.com/cli/azure/install-azure-cli'|
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

################
# Hyperscalers #
################

echo "## Which Hyperscaler do you want to use?" | gum format
HYPERSCALER=$(gum choose "google" "aws" "azure")
echo "export HYPERSCALER=$HYPERSCALER" >> .env

export KUBECONFIG=$PWD/kubeconfig.yaml

echo "export KUBECONFIG=$KUBECONFIG" >> .env

set +e
helm repo add cilium https://helm.cilium.io
set -e

helm repo update

if [[ "$HYPERSCALER" == "google" ]]; then

    set +e
    gcloud components install gke-gcloud-auth-plugin
    set -e

    PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

    echo "export PROJECT_ID=$PROJECT_ID" >> .env

    yq --inplace ".production.google.projectId = \"${PROJECT_ID}\"" settings.yaml

    gcloud projects create ${PROJECT_ID}

    echo "
Please open https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$PROJECT_ID in a browser and *ENABLE* the API."

    gum input --placeholder "
Press the enter key to continue."

    gcloud container clusters create dot --project $PROJECT_ID \
        --zone us-east1-b --machine-type e2-standard-4 \
        --enable-autoscaling --num-nodes 1 --min-nodes 1 \
        --max-nodes 3 --enable-network-policy \
        --node-taints node.cilium.io/agent-not-ready=true:NoExecute \
        --no-enable-autoupgrade

    gcloud container clusters get-credentials dot \
        --project $PROJECT_ID --zone us-east1-b

    NATIVE_CIDR="$(gcloud container clusters describe dot \
        --zone us-east1-b --project $PROJECT_ID \
        --format 'value(clusterIpv4Cidr)')"

    helm install cilium cilium/cilium --version "1.14.4" \
        --namespace kube-system --set nodeinit.enabled=true \
        --set nodeinit.reconfigureKubelet=true \
        --set nodeinit.removeCbrBridge=true \
        --set cni.binPath=/home/kubernetes/bin \
        --set gke.enabled=true --set ipam.mode=kubernetes \
        --set ipv4NativeRoutingCIDR=$NATIVE_CIDR --wait

elif [[ "$HYPERSCALER" == "aws" ]]; then


    AWS_ACCESS_KEY_ID=$(gum input --placeholder "AWS Access Key ID" --value "$AWS_ACCESS_KEY_ID")
    echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> .env
    
    AWS_SECRET_ACCESS_KEY=$(gum input --placeholder "AWS Secret Access Key" --value "$AWS_SECRET_ACCESS_KEY" --password)
    echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> .env

    AWS_ACCOUNT_ID=$(gum input --placeholder "AWS Account ID" --value "$AWS_ACCOUNT_ID")
    echo "export AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID" >> .env

    echo "[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
" >aws-creds.conf

    eksctl create cluster \
        --config-file eksctl/config-cilium.yaml \
        --kubeconfig kubeconfig.yaml

    sleep 10

    kubectl --namespace kube-system patch daemonset aws-node \
        --type strategic \
        --patch '{"spec":{"template":{"spec":{"nodeSelector":{"io.cilium/aws-node-enabled":"true"}}}}}'

    helm install cilium cilium/cilium \
        --version "1.15.0" --namespace kube-system \
        --set eni.enabled=true --set ipam.mode=eni \
        --set routingMode=native \
        --set egressMasqueradeInterfaces=eth0 --wait

    eksctl create addon --name aws-ebs-csi-driver --cluster dot-production \
        --service-account-role-arn arn:aws:iam::$AWS_ACCOUNT_ID:role/AmazonEKS_EBS_CSI_DriverRole \
        --region us-east-1 --force

elif [[ "$HYPERSCALER" == "azure" ]]; then

    az login

    RESOURCE_GROUP=dot-$(date +%Y%m%d%H%M%S)

    echo "export RESOURCE_GROUP=$RESOURCE_GROUP" >> .env

    yq --inplace ".production.azure.resourceGroup = \"${RESOURCE_GROUP}\"" settings.yaml

    export LOCATION=eastus

    yq --inplace ".production.azure.location = \"${LOCATION}\"" settings.yaml

    az group create --name $RESOURCE_GROUP --location $LOCATION

    az aks create --resource-group $RESOURCE_GROUP --name dot \
        --node-count 3 --node-vm-size Standard_B2s \
        --enable-managed-identity --network-plugin none \
        --generate-ssh-keys --yes

    az aks get-credentials --resource-group $RESOURCE_GROUP \
        --name dot --file $KUBECONFIG

    helm install cilium cilium/cilium --version "1.14.2" \
        --namespace kube-system --set aksbyocni.enabled=true \
        --set nodeinit.enabled=true --wait

fi

################
# Setup GitOps #
################

kubectl create namespace production

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
    'We are about to install Argo CD.' \
    'If you prefer a solution other than Argo CD for GitOps,
  please go back to the prod.md or an earlier chapter.'

gum confirm "
Continue?
" || exit 0

REPO_URL=$(git config --get remote.origin.url)

yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/apps.yaml

helm upgrade --install argocd argo-cd \
    --repo https://argoproj.github.io/argo-helm \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

kubectl apply --filename argocd/project.yaml

kubectl apply --filename argocd/apps.yaml

GITOPS_APP=argocd

echo "export GITOPS_APP=$GITOPS_APP" >> .env

yq --inplace ".gitOps.app = \"$GITOPS_APP\"" settings.yaml

#################
# Setup Ingress #
#################

cp $GITOPS_APP/contour.yaml infra/.

git add . 

git commit -m "Contour"

git push

COUNTER=$(kubectl --namespace projectcontour get pods)

while [ -z "$COUNTER" ]; do
    sleep 10
    COUNTER=$(kubectl --namespace projectcontour get pods)
done

sleep 10

if [[ "$HYPERSCALER" == "aws" ]]; then

    INGRESS_IPNAME=$(kubectl --namespace projectcontour get service contour-envoy --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

    INGRESS_IP=$(dig +short $INGRESS_IPNAME) 

    while [ -z "$INGRESS_IP" ]; do
        sleep 10
        INGRESS_IPNAME=$(kubectl --namespace projectcontour get service contour-envoy --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")
        INGRESS_IP=$(dig +short $INGRESS_IPNAME) 
    done

else

    INGRESS_IP=$(kubectl --namespace projectcontour \
        get service contour-envoy \
        --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

    while [ -z "$INGRESS_IP" ]; do
        sleep 10
        INGRESS_IP=$(kubectl --namespace projectcontour \
            get service contour-envoy \
            --output jsonpath="{.status.loadBalancer.ingress[0].ip}")
    done

fi

INGRESS_IP=$(echo $INGRESS_IP | awk '{print $1;}')

INGRESS_IP_LINES=$(echo $INGRESS_IP | wc -l | tr -d ' ')

if [ $INGRESS_IP_LINES -gt 1 ]; then
    INGRESS_IP=$(echo $INGRESS_IP | head -n 1)
fi

echo "export INGRESS_HOST=$INGRESS_IP.nip.io" >> .env
yq --inplace ".ingress.host = \"$INGRESS_IP.nip.io\"" settings.yaml

echo "export INGRESS_CLASSNAME=contour" >> .env
yq --inplace ".ingress.classname = \"contour\"" settings.yaml
