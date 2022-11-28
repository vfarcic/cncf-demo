# Setup Prerequisites

```bash
git clone https://github.com/vfarcic/cncf-demo

cd cncf-demo

# TODO: Create branches for different providers
```

* Create a management Kubernetes cluster (e.g., GKE, EKS, AKS, etc.).

```bash
export KUBECONFIG=$PWD/kubeconfig-dev.yaml

# If using GKE
export PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

# If using GKE
gcloud projects create $PROJECT_ID

# If using GKE
echo https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$PROJECT_ID

# If using GKE
# Open the URL from the output and enable the Kubernetes API

# If using GKE
gcloud container clusters create dot --project $PROJECT_ID \
    --region us-east1 --machine-type n1-standard-2 --num-nodes 1

helm repo add traefik https://helm.traefik.io/traefik

helm repo update

helm upgrade --install \
    traefik traefik/traefik \
    --namespace traefik \
    --create-namespace \
    --wait

# If NOT EKS
export INGRESS_HOST=$(kubectl \
    --namespace traefik \
    get svc traefik \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

# If EKS
export INGRESS_HOST=$(kubectl \
    --namespace traefik \
    get svc traefik \
    --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

echo $INGRESS_HOST

# Use the output to configure DNS domain

# Replace `[...]` with the domain (e.g., sillydemo.com)
export DOMAIN=[...]

# Configure DNS for the following subdomains:
# - harbor
# - notary
# - dev.cncf-demo

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

yq --inplace \
    ".spec.acme.email = \"$EMAIL\"" \
    cert-manager/issuer.yaml

kubectl apply --filename cert-manager/issuer.yaml

ping $DOMAIN

# Confirm that the domain is responding from the specified IP
```

## Start The Adventure

* [Build Container Image](build-container-image/story.md)