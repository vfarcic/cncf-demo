# Setup Prerequisites

```bash
git clone https://github.com/vfarcic/cncf-demo

cd cncf-demo
```

* Create a management Kubernetes cluster (e.g., GKE, EKS, AKS, etc.).

```bash
helm repo add traefik \
    https://helm.traefik.io/traefik

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

# Install `yq` CLI from https://github.com/mikefarah/yq

kubectl create namespace dev
```
