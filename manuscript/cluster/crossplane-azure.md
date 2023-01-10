# Create And Manage Production Azure AKS Cluster With Crossplane

TODO: Intro

## Setup

* You can skip the steps in this section if you already used Crossplane with AWS in one of the previous chapters.

```bash
export SUBSCRIPTION_ID=$(az account show --query id -o tsv)

az ad sp create-for-rbac --sdk-auth --role Owner \
    --scopes /subscriptions/$SUBSCRIPTION_ID \
    | tee azure-creds.json

kubectl --namespace crossplane-system \
    create secret generic azure-creds \
    --from-file creds=./azure-creds.json

kubectl apply \
    --filename crossplane-config/provider-azure-official.yaml

kubectl get pkgrev

# Wait until all the packages are healthy

kubectl apply \
    --filename crossplane-config/provider-config-azure-official.yaml
```

## Do

```bash
export XP_DESTINATION=azure

cat crossplane/azure-aks.yaml

kubectl --namespace production apply \
    --filename crossplane/azure-aks.yaml

# TODO: Remove
# kubectl get resourcegroup.azure.upbound.io,kubernetescluster.containerservice.azure.upbound.io,release.helm.crossplane.io,object.kubernetes.crossplane.io

kubectl get managed

kubectl --namespace production get clusterclaims

cat crossplane/get-kubeconfig-$XP_DESTINATION.sh

./crossplane/get-kubeconfig-$XP_DESTINATION.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

kubectl get nodes
```

## Continue The Adventure

[GitOps](../gitops/story.md)
