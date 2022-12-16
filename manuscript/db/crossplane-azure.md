# Setup PostgreSQL DB In Azure With Crossplane

TODO: Intro

## Setup

```bash
export SUBSCRIPTION_ID=$(az account show --query id -o tsv)

az ad sp create-for-rbac --sdk-auth --role Owner \
    --scopes /subscriptions/$SUBSCRIPTION_ID \
    | tee azure-creds.json

helm repo add crossplane-stable \
    https://charts.crossplane.io/stable

helm repo update

helm upgrade --install crossplane crossplane-stable/crossplane \
    --namespace crossplane-system --create-namespace --wait

kubectl --namespace crossplane-system \
    create secret generic azure-creds \
    --from-file creds=./azure-creds.json

kubectl apply \
    --filename crossplane-config/provider-kubernetes-incluster.yaml

kubectl apply \
    --filename crossplane-config/provider-azure-official.yaml

kubectl apply --filename crossplane-config/config-sql.yaml

kubectl get pkgrev

# Wait until all the packages are healthy

kubectl apply \
    --filename crossplane-config/provider-config-azure-official.yaml

export XP_DESTINATION=azure
```

## How Did You Define Your App?

* [Helm](crossplane-helm.md)
* [Kustomize](crossplane-kustomize.md)
* [Carvel](crossplane-carvel.md)