# Setup Prerequisites

```bash
git clone https://github.com/vfarcic/cncf-demo

cd cncf-demo

export KUBECONFIG=$PWD/kubeconfig-dev.yaml
```

* Create a management Kubernetes cluster (e.g., GKE, EKS, AKS, etc.).

```bash
# If using EKS
# Replace `[...]` with your access key ID`
export AWS_ACCESS_KEY_ID=[...]

# If using EKS
# Replace `[...]` with your secret access key
export AWS_SECRET_ACCESS_KEY=[...]

# If using EKS
eksctl create cluster --name dot --region us-east-1 \
    --version 1.24 --nodegroup-name primary \
    --node-type t3.medium --nodes-min 3 --nodes-max 6 \
    --managed --asg-access

# If using AKS
export RESOURCE_GROUP=dot-$(date +%Y%m%d%H%M%S)

# If using AKS
az group create --location eastus --name $RESOURCE_GROUP

# If using AKS
# Change `1.25.2` to the Kubernetes version you want to use
export K8S_VERSION=1.25.2

# If using AKS
az aks create --name dot --resource-group $RESOURCE_GROUP \
    --node-count 3 --node-vm-size Standard_D2_v2 \
    --kubernetes-version $K8S_VERSION

# If using AKS
az aks get-credentials --name dot \
    --resource-group $RESOURCE_GROUP --file $KUBECONFIG

# If using GKE
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# If using GKE
export PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

# If using GKE
gcloud projects create $PROJECT_ID

# If using GKE
echo https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$PROJECT_ID

# If using GKE
# Open the URL from the output and enable the Kubernetes API

# If using GKE
gcloud container get-server-config --region us-east1

# Replace `[...]` with a valid master version from the previous output.
export K8S_VERSION=[...]

# If using GKE
gcloud container clusters create dot --project $PROJECT_ID \
    --region us-east1 --machine-type n1-standard-4 \
    --num-nodes 1 --cluster-version $K8S_VERSION \
    --node-version $K8S_VERSION

# If using GKE
gcloud container clusters get-credentials dot \
    --project $PROJECT_ID --region us-east1

helm repo add traefik https://helm.traefik.io/traefik

helm repo update

helm upgrade --install traefik traefik/traefik \
    --namespace traefik --create-namespace --wait

# If NOT EKS
export INGRESS_HOST=$(kubectl --namespace traefik \
    get svc traefik \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

# If EKS
export INGRESS_HOST=$(kubectl --namespace traefik \
    get svc traefik \
    --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

echo $INGRESS_HOST

# Repeat the `export` commands if the output is empty

# If the output contains more than one IP, wait for a while longer, and repeat the `export` commands.

# If the output continues having more than one IP, choose one of them and execute `export INGRESS_HOST=[...]` with `[...]` being the selected IP.

# Use the output to configure DNS domain

# Replace `[...]` with the domain (e.g., sillydemo.com)
export DOMAIN=[...]

# Configure DNS for the following subdomains:
# - harbor
# - notary
# - dev.cncf-demo

# Do not use a wildcard for those subdomains since, later on,
#   we'll add more pointing to a different cluster.

kubectl create namespace dev

helm repo add jetstack https://charts.jetstack.io

helm repo update

helm upgrade --install cert-manager jetstack/cert-manager \
    --namespace cert-manager --create-namespace \
    --set installCRDs=true --wait

# Replace `[...]` with your email
export EMAIL=[...]

# Install `yq` CLI from https://github.com/mikefarah/yq
# Install `jq` CLI from https://stedolan.github.io/jq/download

yq --inplace ".spec.acme.email = \"$EMAIL\"" \
    cert-manager/issuer.yaml

kubectl apply --filename cert-manager/issuer.yaml
```

## Start The Adventure

* [Build Container Image](build-container-image/story.md)