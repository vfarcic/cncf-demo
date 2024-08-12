#!/usr/bin/env nu

rm .env

let continue = [Yes No]
    | input list $"(ansi green_bold)Are you ready to start?(ansi reset)
Select (ansi yellow_bold)Yes(ansi reset) only if you did NOT follow the story from the start \(if you jumped straight into this chapter).
Feel free to say (ansi yellow_bold)No(ansi reset) and inspect the script if you prefer setting up resources manually.(ansi yellow_bold)
"

if continue == No { exit }

print $"(ansi purple_bold)
################
# Hyperscalers #
################
(ansi reset)"

let hyperscaler = [google aws azure]
    | input list $"(ansi green_bold)Which Hyperscaler do you want to use?(ansi yellow_bold)"
$"export HYPERSCALER=($hyperscaler)\n" | save --append .env

$env.KUBECONFIG = $"($env.PWD)/kubeconfig.yaml"
$"export KUBECONFIG=($env.KUBECONFIG)\n" | save --append .env

helm repo add cilium https://helm.cilium.io
helm repo update

if hyperscaler == "google" {

    let project_id = $"dot-(date now | format date "%Y%m%d%H%M%S")"
    $"export PROJECT_ID=($project_id)\n" | save --append .env

    open settings.yaml
        | upsert production.google.projectId $project_id
        | save settings.yaml --force

    gcloud projects create $project_id

    start $"https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=($project_id)"

    print $"(ansi yellow_bold)
    ENABLE(ansi reset) the API.
    Press any key to continue.
    "
    input

    start $"https://console.cloud.google.com/apis/library/sqladmin.googleapis.com?project=($project_id)"
    print $"(ansi yellow_bold)
    ENABLE(ansi reset) the API.
    Press any key to continue.
    "
    input

    (
        gcloud container clusters create dot --project $project_id
            --zone us-east1-b --machine-type e2-standard-8
            --enable-autoscaling --num-nodes 1 --min-nodes 1
            --max-nodes 3 --enable-network-policy
            --node-taints node.cilium.io/agent-not-ready=true:NoExecute
            --no-enable-autoupgrade
    )

    (
        gcloud container clusters get-credentials dot
            --project $project_id --zone us-east1-b
    )

    let clusterIpv4Cidr = (
        gcloud container clusters describe dot
            --zone us-east1-b --project $project_id
    ) | from yaml | get "clusterIpv4Cidr"
    
    (
        helm upgrade --install cilium cilium/cilium
            --version "1.14.4" --namespace kube-system
            --set nodeinit.enabled=true
            --set nodeinit.reconfigureKubelet=true
            --set nodeinit.removeCbrBridge=true
            --set cni.binPath=/home/kubernetes/bin
            --set gke.enabled=true --set ipam.mode=kubernetes
            --set ipv4NativeRoutingCIDR=($clusterIpv4Cidr) --wait
    )

    let sa_name = "devops-toolkit"

    let sa = $"($sa_name)@($project_id).iam.gserviceaccount.com"

    (
        gcloud iam service-accounts create $sa_name 
            --project $project_id
    )

    (
        gcloud projects add-iam-policy-binding
            --role roles/admin $project_id
            --member $"serviceAccount:($sa)"
    )

    (
        gcloud iam service-accounts keys create gcp-creds.json
            --project $project_id --iam-account $sa
    )

} else if hyperscaler == "aws" {

#     AWS_ACCESS_KEY_ID=$(gum input --placeholder "AWS Access Key ID" --value "$AWS_ACCESS_KEY_ID")
#     echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> .env
    
#     AWS_SECRET_ACCESS_KEY=$(gum input --placeholder "AWS Secret Access Key" --value "$AWS_SECRET_ACCESS_KEY" --password)
#     echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> .env

#     AWS_ACCOUNT_ID=$(gum input --placeholder "AWS Account ID" --value "$AWS_ACCOUNT_ID")
#     echo "export AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID" >> .env

#     echo "[default]
# aws_access_key_id = $AWS_ACCESS_KEY_ID
# aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
# " >aws-creds.conf

#     eksctl create cluster \
#         --config-file eksctl/config-cilium.yaml \
#         --kubeconfig kubeconfig.yaml

#     sleep 10

#     kubectl --namespace kube-system patch daemonset aws-node \
#         --type strategic \
#         --patch '{"spec":{"template":{"spec":{"nodeSelector":{"io.cilium/aws-node-enabled":"true"}}}}}'

#     helm install cilium cilium/cilium \
#         --version "1.15.0" --namespace kube-system \
#         --set eni.enabled=true --set ipam.mode=eni \
#         --set routingMode=native \
#         --set egressMasqueradeInterfaces=eth0 --wait

#     eksctl create addon --name aws-ebs-csi-driver --cluster dot-production \
#         --service-account-role-arn arn:aws:iam::$AWS_ACCOUNT_ID:role/AmazonEKS_EBS_CSI_DriverRole \
#         --region us-east-1 --force

# elif [[ "$HYPERSCALER" == "azure" ]]; then

#     az login

#     RESOURCE_GROUP=dot-$(date +%Y%m%d%H%M%S)

#     echo "export RESOURCE_GROUP=$RESOURCE_GROUP" >> .env

#     yq --inplace ".production.azure.resourceGroup = \"${RESOURCE_GROUP}\"" settings.yaml

#     export LOCATION=eastus

#     yq --inplace ".production.azure.location = \"${LOCATION}\"" settings.yaml

#     az group create --name $RESOURCE_GROUP --location $LOCATION

#     az aks create --resource-group $RESOURCE_GROUP --name dot \
#         --node-count 3 --node-vm-size Standard_B2ms \
#         --enable-managed-identity --network-plugin none \
#         --generate-ssh-keys --yes

#     az aks get-credentials --resource-group $RESOURCE_GROUP \
#         --name dot --file $KUBECONFIG

#     helm install cilium cilium/cilium --version "1.14.2" \
#         --namespace kube-system --set aksbyocni.enabled=true \
#         --set nodeinit.enabled=true --wait

}

print $"(ansi purple_bold)
################
# Setup GitOps #
################
(ansi reset)"

kubectl create namespace production

let continue = [Yes No]
    | input list $"We are about to install Argo CD.
If you prefer a solution other than Argo CD for GitOps, please go back to the prod.md or an earlier chapter.
(ansi green_bold)Continue?(ansi reset)
"

if continue == No { exit }

let repo_url = git config --get remote.origin.url

open argocd/app-apps.yaml
    | upsert spec.source.repoURL $repo_url
    | save argocd/app-apps.yaml --force

open argocd/app-infra.yaml
    | upsert spec.source.repoURL $repo_url
    | save argocd/app-infra.yaml --force

(
    helm upgrade --install argocd argo-cd 
        --repo https://argoproj.github.io/argo-helm 
        --namespace argocd --create-namespace 
        --values argocd/helm-values.yaml --wait
)

kubectl apply --filename argocd/project.yaml

kubectl apply --filename argocd/app-apps.yaml

kubectl apply --filename argocd/app-infra.yaml

let gitops_app = "argocd"

$"export GITOPS_APP=($gitops_app)\n" | save --append .env

open settings.yaml
    | upsert gitOps.app $gitops_app
    | save settings.yaml --force

# #################
# # Setup Ingress #
# #################

# cp $GITOPS_APP/contour.yaml infra/.

# git add . 

# git commit -m "Contour"

# git push

# COUNTER=$(kubectl --namespace projectcontour get pods)

# while [ -z "$COUNTER" ]; do
#     sleep 10
#     COUNTER=$(kubectl --namespace projectcontour get pods)
# done

# sleep 10

# if [[ "$HYPERSCALER" == "aws" ]]; then

#     INGRESS_IPNAME=$(kubectl --namespace projectcontour get service contour-envoy --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

#     INGRESS_IP=$(dig +short $INGRESS_IPNAME) 

#     while [ -z "$INGRESS_IP" ]; do
#         sleep 10
#         INGRESS_IPNAME=$(kubectl --namespace projectcontour get service contour-envoy --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")
#         INGRESS_IP=$(dig +short $INGRESS_IPNAME) 
#     done

# else

#     INGRESS_IP=$(kubectl --namespace projectcontour get service contour-envoy --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

#     while [ -z "$INGRESS_IP" ]; do
#         sleep 10
#         INGRESS_IP=$(kubectl --namespace projectcontour get service contour-envoy --output jsonpath="{.status.loadBalancer.ingress[0].ip}")
#     done

# fi

# INGRESS_IP=$(echo $INGRESS_IP | awk '{print $1;}')

# INGRESS_IP_LINES=$(echo $INGRESS_IP | wc -l | tr -d ' ')

# if [ $INGRESS_IP_LINES -gt 1 ]; then
#     INGRESS_IP=$(echo $INGRESS_IP | head -n 1)
# fi

# echo "export INGRESS_HOST=$INGRESS_IP.nip.io" >> .env
# yq --inplace ".ingress.host = \"$INGRESS_IP.nip.io\"" settings.yaml

# echo "export INGRESS_CLASSNAME=contour" >> .env
# yq --inplace ".ingress.classname = \"contour\"" settings.yaml

# #################
# # Setup The App #
# #################

# yq --inplace ".image = \"index.docker.io/vfarcic/cncf-demo\"" settings.yaml

# yq --inplace ".tag = \"v0.0.1\"" settings.yaml

# echo "
# How would you like to define Kubernetes resources?"

# TEMPLATES=$(gum choose "kustomize" "helm" "ytt" "cdk8s")

# echo "export TEMPLATES=$TEMPLATES" >> .env
# yq --inplace ".templates = \"$TEMPLATES\"" settings.yaml

# if [[ "$TEMPLATES" == "kustomize" ]]; then

#     yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" $GITOPS_APP/cncf-demo-kustomize.yaml

#     yq --inplace ".spec.template.spec.containers[0].image = \"index.docker.io/vfarcic/cncf-demo\"" kustomize/base/deployment.yaml

#     cd kustomize/overlays/prod

#     kustomize edit set image index.docker.io/vfarcic/cncf-demo=index.docker.io/vfarcic/cncf-demo:v0.0.1

#     cd ../../..

#     yq --inplace ".patchesStrategicMerge = []" kustomize/overlays/prod/kustomization.yaml

# elif [[ "$TEMPLATES" == "helm" ]]; then

#     yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
#         argocd/cncf-demo-helm.yaml

#     yq --inplace \
#         ".image.repository = \"index.docker.io/vfarcic/cncf-demo\"" \
#         helm/app/values.yaml

#     yq --inplace \
#         ".spec.source.helm.valuesObject.image.tag = \"v0.0.1\"" \
#         argocd/cncf-demo-helm.yaml

#     yq --inplace \
#         ".spec.source.helm.valuesObject.tls.enabled = false" \
#         argocd/cncf-demo-helm.yaml

# elif [[ "$TEMPLATES" == "cdk8s" ]]; then

#     yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" $GITOPS_APP/cncf-demo-cdk8s.yaml

#     yq --inplace ".image.repository = \"index.docker.io/vfarcic/cncf-demo\"" cdk8s/app-prod.yaml

#     yq --inplace ".image.tag = \"v0.0.1\"" cdk8s/app-prod.yaml

# else

#     yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" $GITOPS_APP/cncf-demo-ytt.yaml

#     yq --inplace ".image.repository = \"index.docker.io/vfarcic/cncf-demo\"" ytt/values-prod.yaml

#     yq --inplace ".image.tag = \"v0.0.1\"" ytt/values-prod.yaml

# fi

# ####################
# # Setup Crossplane #
# ####################

# set +e
# helm repo add crossplane-stable https://charts.crossplane.io/stable
# set -e

# helm repo update

# helm upgrade --install crossplane crossplane-stable/crossplane --namespace crossplane-system --create-namespace --wait

# kubectl apply --filename crossplane-config/provider-kubernetes-incluster.yaml

# kubectl apply --filename crossplane-config/config-sql.yaml

# sleep 60

# kubectl wait --for=condition=healthy provider.pkg.crossplane.io --all --timeout=600s

# if [[ "$HYPERSCALER" == "google" ]]; then

#     kubectl --namespace crossplane-system create secret generic gcp-creds --from-file creds=./gcp-creds.json

#     echo "apiVersion: gcp.upbound.io/v1beta1
# kind: ProviderConfig
# metadata:
#   name: default
# spec:
#   projectID: $PROJECT_ID
#   credentials:
#     source: Secret
#     secretRef:
#       namespace: crossplane-system
#       name: gcp-creds
#       key: creds" | kubectl apply --filename -

#     yq --inplace ".crossplane.destination = \"google\"" settings.yaml

# elif [[ "$HYPERSCALER" == "aws" ]]; then

#     kubectl --namespace crossplane-system create secret generic aws-creds --from-file creds=./aws-creds.conf

#     kubectl apply --filename crossplane-config/provider-config-aws-official.yaml

#     yq --inplace ".crossplane.destination = \"aws\"" settings.yaml

# elif [[ "$HYPERSCALER" == "azure" ]]; then

#     export SUBSCRIPTION_ID=$(az account show --query id -o tsv)

#     az ad sp create-for-rbac --sdk-auth --role Owner --scopes /subscriptions/$SUBSCRIPTION_ID | tee azure-creds.json

#     kubectl --namespace crossplane-system create secret generic azure-creds --from-file creds=./azure-creds.json

#     kubectl apply --filename crossplane-config/provider-config-azure-official.yaml

#     yq --inplace ".crossplane.destination = \"azure\"" settings.yaml

# fi

# ##################
# # Setup Database #
# ##################

# if [[ "$TEMPLATES" == "kustomize" ]]; then

#     yq --inplace ".resources += \"postgresql-crossplane-$HYPERSCALER.yaml\"" kustomize/overlays/prod/kustomization.yaml

#     yq --inplace ".resources += \"postgresql-crossplane-secret-$HYPERSCALER.yaml\"" kustomize/overlays/prod/kustomization.yaml

#     yq --inplace ".patchesStrategicMerge += \"deployment-crossplane-postgresql-$HYPERSCALER.yaml\"" kustomize/overlays/prod/kustomization.yaml

#     yq --inplace ".resources += \"postgresql-crossplane-schema-$HYPERSCALER.yaml\"" kustomize/overlays/prod/kustomization.yaml

# elif [[ "$TEMPLATES" == "helm" ]]; then

#     yq --inplace \
#         ".spec.source.helm.valuesObject.db.enabled.crossplane.$HYPERSCALER = true" \
#         argocd/cncf-demo-helm.yaml

#     yq --inplace \
#         ".spec.source.helm.valuesObject.db.insecure = true" \
#         argocd/cncf-demo-helm.yaml

# elif [[ "$TEMPLATES" == "cdk8s" ]]; then

#     yq --inplace ".db.enabled.crossplane.$HYPERSCALER = true" cdk8s/app-prod.yaml

#     yq --inplace ".db.id = \"cncf-demo-db\"" cdk8s/app-prod.yaml

#     yq --inplace ".db.insecure = true" cdk8s/app-prod.yaml

#     yq --inplace ".db.size = \"small\"" cdk8s/app-prod.yaml

#     yq --inplace ".schemahero.enabled = true" cdk8s/app-prod.yaml

#     cd cdk8s

#     ENVIRONMENT=prod cdk8s synth --output ../yaml/prod --validate

#     cd ../

# else

#     yq --inplace ".db.enabled.crossplane.$HYPERSCALER = true" ytt/values-prod.yaml

#     yq --inplace ".db.id = \"cncf-demo-db\"" ytt/values-prod.yaml

#     yq --inplace ".db.insecure = true" ytt/values-prod.yaml

#     yq --inplace ".db.size = \"small\"" ytt/values-prod.yaml

#     yq --inplace ".schemahero.enabled = true" ytt/values-prod.yaml

#     ytt --file ytt/schema.yaml --file ytt/resources --data-values-file ytt/values-prod.yaml | tee yaml/prod/app.yaml

# fi

# #######################
# # Setup Dabase Schema #
# #######################

# cp argocd/schema-hero.yaml infra/.

# git add .

# git commit -m "SchemaHero"

# git push
