# Setup PostgreSQL DB In The Dev Kubernetes With Crossplane

TODO: Intro

## Setup

```bash
helm repo add crossplane-stable \
    https://charts.crossplane.io/stable

helm repo update

helm upgrade --install \
    crossplane crossplane-stable/crossplane \
    --namespace crossplane-system \
    --create-namespace \
    --wait

kubectl apply \
    --filename crossplane-config/provider-kubernetes-incluster.yaml

kubectl apply \
    --filename crossplane-config/provider-helm-incluster.yaml

kubectl apply \
    --filename crossplane-config/config-sql.yaml

export XP_DESTINATION=local
```

## How Did You Define Your App?

* [Helm](crossplane-local-helm.md)
* [Kustomize](crossplane-local-kustomize.md)
* [Carvel](crossplane-local-carvel.md)