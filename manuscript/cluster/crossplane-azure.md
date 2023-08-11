# Create and Manage Production Azure AKS Cluster with Crossplane

In this section, we will create and manage a production-grade Azure AKS cluster using Crossplane.

Among other things, this involves:
* installing the Crossplane Azure Provider which creates a new Kubernetes API for every external Azure API
* creating the Azure Provider Config which provides Crossplane with credentials to be able to access and change Azure cloud resources

Once this is done, we are able to provision Kubernetes clusters in Azure using Crossplane Custom Resources. 

## Setup

* You can skip the steps in this section (Setup) if you already used Crossplane with Azure in one of the previous chapters.

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

kubectl get managed

kubectl --namespace production get claim

# Wait until the claim is ready

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

* [GitOps](../gitops/README.md)
