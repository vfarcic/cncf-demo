# Use HTTPS With cert-manager

TODO: Intro

## Setup

```bash
helm repo add jetstack https://charts.jetstack.io

helm repo update

helm upgrade --install cert-manager jetstack/cert-manager \
    --namespace cert-manager --create-namespace \
    --set installCRDs=true --wait

# Replace `[...]` with your email
export EMAIL=[...]

yq --inplace \
    ".spec.acme.email = \"$EMAIL\"" \
    cert-manager/issuer.yaml

kubectl apply --filename cert-manager/issuer.yaml
```

## How Did You Define Your App?

* [Helm](cert-manager-helm.md)
* [Kustomize](cert-manager-kustomize.md)
* [Carvel](cert-manager-carvel.md)