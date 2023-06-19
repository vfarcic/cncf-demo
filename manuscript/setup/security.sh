#!/bin/sh
set -e

rm .env

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the Security chapter.
  
This script assumes that you jumped straight into this chapter.
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
|gitHub CLi      |Yes                  |'https://youtu.be/BII6ZY2Rnlc'                     |
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
|Google Cloud CLI|If using Google Cloud|'https://cloud.google.com/sdk/docs/install'        |
|AWS CLI         |If using AWS         |'https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html'|
|eksctl          |If using AWS         |'https://eksctl.io/introduction/#installation'     |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
    'You need a Kubernetes cluster.' \
    'Do NOT use a local Kubernetes cluster since all the tools
  we will run might be too much for your machine.'

################
# Hyperscalers #
################

echo "
Which Hyperscaler do you want to use?"

HYPERSCALER=$(gum choose "google" "aws" "azure")

echo "export HYPERSCALER=$HYPERSCALER" >> .env

KUBECONFIG=$PWD/kubeconfig.yaml

echo "export KUBECONFIG=$KUBECONFIG" >> .env

if [[ "$HYPERSCALER" == "google" ]]; then

    USE_GKE_GCLOUD_AUTH_PLUGIN=True

    export PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

    echo "export PROJECT_ID=$PROJECT_ID" >> .env

    yq --inplace ".production.google.projectId = \"${PROJECT_ID}\"" settings.yaml

    gcloud projects create ${PROJECT_ID}

    echo "
Please open https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$PROJECT_ID in a browser and *ENABLE* the API."

    gum input --placeholder "
Press the enter key to continue."

    echo "
Please open https://console.cloud.google.com/apis/library/sqladmin.googleapis.com?project=${PROJECT_ID} in a browser and *ENABLE* the API."

    gum input --placeholder "
Press the enter key to continue."

    gcloud container clusters create dot --project $PROJECT_ID \
        --region us-east1 --machine-type e2-standard-4 \
        --num-nodes 1 --enable-network-policy \
        --no-enable-autoupgrade

    export SA_NAME=devops-toolkit

    export SA="${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

    gcloud iam service-accounts create $SA_NAME --project $PROJECT_ID

    export ROLE=roles/admin

    gcloud projects add-iam-policy-binding --role $ROLE $PROJECT_ID --member serviceAccount:$SA

    gcloud iam service-accounts keys create gcp-creds.json --project $PROJECT_ID --iam-account $SA

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

  eksctl create cluster --config-file eksctl/config-dev.yaml \
      --kubeconfig kubeconfig.yaml

  eksctl create addon --name aws-ebs-csi-driver --cluster dot \
      --service-account-role-arn arn:aws:iam::$AWS_ACCOUNT_ID:role/AmazonEKS_EBS_CSI_DriverRole \
      --force

else

    gum style \
        --foreground 212 --border-foreground 212 --border double \
        --margin "1 2" --padding "2 4" \
        'Unfortunately, the demo currently does NOT work in Azure.' \
        '
Please let me know in the comments of the video if you would like
me to add the commands for Azure.' \
        '
I will do my best to add the commands if there is interest or you
can create a pull request if you would like to contribute.'

    exit 0

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

export REPO_URL=$(git config --get remote.origin.url)

yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" argocd/apps.yaml

helm upgrade --install argocd argo-cd --repo https://argoproj.github.io/argo-helm --namespace argocd --create-namespace --values argocd/helm-values.yaml --wait

kubectl apply --filename argocd/project.yaml

kubectl apply --filename argocd/apps.yaml

export GITOPS_APP=argocd

yq --inplace ".gitOps.app = \"$GITOPS_APP\"" settings.yaml

#################
# Setup The App #
#################

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
    'We are about to setup Kustomize.' \
    'If you prefer a solution other than Kustomize for defining
and packaging applications, please go back to the prod.md or an
earlier chapter.'

gum confirm "
Continue?
" || exit 0

yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" $GITOPS_APP/cncf-demo-kustomize.yaml

yq --inplace ".image = \"index.docker.io/vfarcic/cncf-demo\"" settings.yaml

yq --inplace ".tag = \"v0.0.1\"" settings.yaml

yq --inplace ".spec.template.spec.containers[0].image = \"index.docker.io/vfarcic/cncf-demo\"" kustomize/base/deployment.yaml

cd kustomize/overlays/prod

kustomize edit set image index.docker.io/vfarcic/cncf-demo=index.docker.io/vfarcic/cncf-demo:v0.0.1

cd ../../..

yq --inplace ".patchesStrategicMerge = []" kustomize/overlays/prod/kustomization.yaml

####################
# Setup Crossplane #
####################

helm repo add crossplane-stable https://charts.crossplane.io/stable

helm repo update

helm upgrade --install crossplane crossplane-stable/crossplane --namespace crossplane-system --create-namespace --wait

kubectl apply --filename crossplane-config/provider-kubernetes-incluster.yaml

kubectl apply --filename crossplane-config/config-sql.yaml

sleep 60

kubectl wait --for=condition=healthy provider.pkg.crossplane.io --all --timeout=300s

if [[ "$HYPERSCALER" == "google" ]]; then

    kubectl --namespace crossplane-system create secret generic gcp-creds --from-file creds=./gcp-creds.json

    echo "apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  projectID: $PROJECT_ID
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gcp-creds
      key: creds" | kubectl apply --filename -

    yq --inplace ".crossplane.destination = \"google\"" settings.yaml

elif [[ "$HYPERSCALER" == "aws" ]]; then

    kubectl --namespace crossplane-system create secret generic aws-creds --from-file creds=./aws-creds.conf

    kubectl apply --filename crossplane-config/provider-config-aws-official.yaml

    yq --inplace ".crossplane.destination = \"aws\"" settings.yaml

else

    gum style \
        --foreground 212 --border-foreground 212 --border double \
        --margin "1 2" --padding "2 4" \
        'Unfortunately, the demo currently does NOT work in Azure.' \
        '
Please let me know in the comments of the video if you would like
me to add the commands for Azure.' \
        '
I will do my best to add the commands if there is interest or you
can create a pull request if you would like to contribute.'

    exit 0

fi

##################
# Setup Database #
##################

yq --inplace ".resources += \"postgresql-crossplane-$HYPERSCALER.yaml\"" kustomize/overlays/prod/kustomization.yaml

yq --inplace ".resources += \"postgresql-crossplane-secret-$HYPERSCALER.yaml\"" kustomize/overlays/prod/kustomization.yaml

yq --inplace ".patchesStrategicMerge += \"deployment-crossplane-postgresql-$HYPERSCALER.yaml\"" kustomize/overlays/prod/kustomization.yaml

yq --inplace ".resources += \"postgresql-crossplane-schema-$HYPERSCALER.yaml\"" kustomize/overlays/prod/kustomization.yaml

#######################
# Setup Dabase Schema #
#######################

cp argocd/schema-hero.yaml infra/.

git add .

git commit -m "SchemaHero"

git push
