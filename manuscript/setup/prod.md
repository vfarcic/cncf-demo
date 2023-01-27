# Setup Prerequisites

*Go through this document ONLY if you did NOT follow the story from the start (if you jumped straight into this chapter).*

```bash
# Watch https://youtu.be/BII6ZY2Rnlc if you are not familiar with GitHub CLI
gh repo fork vfarcic/cncf-demo --clone --remote

cd cncf-demo

gh repo set-default

# Select the fork as the default repository

export KUBECONFIG=$PWD/kubeconfig-dev.yaml

# Install `yq` CLI from https://github.com/mikefarah/yq
# 'yq' is a lightweight and portable command-line YAML processor
yq --inplace ".kubeConfig = \"$PWD/kubeconfig-dev.yaml\"" \
    settings.yaml

yq --inplace ".image = \"index.docker.io/vfarcic/cncf-demo\"" \
    settings.yaml

yq --inplace ".tag = \"v0.0.1\"" settings.yaml

# Execute this step ONLY if you chose to use `nip.io` instead of
#   a "real" domain
alias curl="curl --insecure"
```

## Create a management Kubernetes cluster

### AWS

Follow this section ONLY if you're planning to use AWS

```bash
# Replace `[...]` with your access key ID`
export AWS_ACCESS_KEY_ID=[...]

# Replace `[...]` with your secret access key
export AWS_SECRET_ACCESS_KEY=[...]

eksctl create cluster --name dot --region us-east-1 \
    --version 1.24 --nodegroup-name primary \
    --node-type t3.medium --nodes-min 3 --nodes-max 6 \
    --managed --asg-access
```

### Azure

Follow this section ONLY if you're planning to use Azure

```bash
export RESOURCE_GROUP=dot-$(date +%Y%m%d%H%M%S)

yq --inplace ".azure.resourceGroup = \"$RESOURCE_GROUP\"" \
    settings.yaml

az group create --location eastus --name $RESOURCE_GROUP

az aks get-versions --location eastus --output table

# Change `1.25.4` to the latest available Kubernetes version
export K8S_VERSION=1.25.4

az aks create --name dot --resource-group $RESOURCE_GROUP \
    --node-count 3 --node-vm-size Standard_D2_v2 \
    --kubernetes-version $K8S_VERSION

az aks get-credentials --name dot \
    --resource-group $RESOURCE_GROUP --file $KUBECONFIG
```

### Google Cloud

Follow this section ONLY if you're planning to use Google Cloud

```bash
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

yq --inplace ".google.projectId = \"$PROJECT_ID\"" \
    settings.yaml

gcloud projects create $PROJECT_ID

echo "https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$PROJECT_ID"

# Open the URL from the output and enable the Kubernetes API

gcloud container get-server-config --region us-east1

# Replace `[...]` with a valid master version from the previous output.
export K8S_VERSION=[...]

gcloud container clusters create dot --project $PROJECT_ID \
    --region us-east1 --machine-type n1-standard-4 \
    --num-nodes 1 --cluster-version $K8S_VERSION \
    --node-version $K8S_VERSION

gcloud container clusters get-credentials dot \
    --project $PROJECT_ID --region us-east1

export XP_PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

yq --inplace \
    ".google.crossplane.projectId = \"$XP_PROJECT_ID\"" \
    settings.yaml

gcloud projects create $XP_PROJECT_ID

export SA_NAME=devops-toolkit

export SA="${SA_NAME}@${XP_PROJECT_ID}.iam.gserviceaccount.com"

gcloud iam service-accounts create $SA_NAME --project $XP_PROJECT_ID

export ROLE=roles/owner

gcloud projects add-iam-policy-binding --role $ROLE $XP_PROJECT_ID \
    --member serviceAccount:$SA

gcloud iam service-accounts keys create gcp-creds.json \
    --project $XP_PROJECT_ID --iam-account $SA
```

### Cluster With Any Other Provider

Follow this section ONLY if you're NOT planning to use EKS, AKS, or GKE

* Create a Kubernetes cluster any way you like, as long as it is not a local cluster (e.g., Docker Desktop, Minikube, etc.)

## Start The Chapter

* [Create And Manage Production Kubernetes Cluster](../cluster/story.md)