# Create and Manage Production Azure AKS Cluster with Crossplane

TODO: Intro

## Setup

* You can skip the steps in this section (the Setup) if you already used Crossplane with Azure in one of the previous chapters.

```bash
export SUBSCRIPTION_ID=$(az account show --query id -o tsv)

az ad sp create-for-rbac --sdk-auth --role Owner \
    --scopes /subscriptions/$SUBSCRIPTION_ID \
    | tee azure-creds.json

kubectl --namespace crossplane-system \
    create secret generic azure-creds \
    --from-file creds=./azure-creds.json

kubectl get pkgrev

# Wait until all the packages are healthy

kubectl apply \
    --filename crossplane-config/provider-config-azure-official.yaml

yq --inplace ".crossplane.destination = \"azure\"" settings.yaml
```

## Do

```bash
cat crossplane/azure-aks.yaml

kubectl --namespace production apply \
    --filename crossplane/azure-aks.yaml

# TODO: Remove
# kubectl get resourcegroup.azure.upbound.io,kubernetescluster.containerservice.azure.upbound.io,release.helm.crossplane.io,object.kubernetes.crossplane.io

kubectl get managed

kubectl --namespace production get claim

cat crossplane/get-kubeconfig-azure.sh

chmod +x crossplane/get-kubeconfig-azure.sh

./crossplane/get-kubeconfig-azure.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

yq --inplace \
    ".production.kubeConfig = \"$PWD/kubeconfig-prod.yaml\"" \
    settings.yaml

kubectl get nodes
```

## Continue the adventure

The adventure will continue soon...
