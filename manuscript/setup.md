# Setup Prerequisites

```bash
git clone https://github.com/vfarcic/cncf-demo

cd cncf-demo
```

* Create a GKE cluster.
* If using a different cluster, some commands or manifests might need to be adjusted.

```bash
helm repo add traefik \
    https://helm.traefik.io/traefik

helm repo update

helm upgrade --install \
    traefik traefik/traefik \
    --namespace traefik \
    --create-namespace \
    --wait

export INGRESS_HOST=$(kubectl \
    --namespace traefik \
    get svc traefik \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

echo $INGRESS_HOST

# Replace `[...]` with the domain configured to point to the Ingress Service IP.
export DOMAIN=[...]

# Use the IP to configure the domain with wildcard subdomains.

# Install `yq` CLI from https://github.com/mikefarah/yq

kubectl create namespace dev

kubectl create namespace production
```

# Setup cert-manager

```bash
helm repo add jetstack https://charts.jetstack.io

helm repo update

helm upgrade --install cert-manager jetstack/cert-manager \
    --namespace cert-manager --create-namespace \
    --set installCRDs=true --wait

# Replace `[...]` with your email
export EMAIL=[...]

yq --inplace ".spec.acme.email = \"$EMAIL\"" \
    cert-manager/issuer.yaml

kubectl apply --filename cert-manager/issuer.yaml
```