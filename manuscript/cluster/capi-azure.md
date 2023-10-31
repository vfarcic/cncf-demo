# Create and Manage Production Azure AKS Cluster with ClusterAPI

In this section, we will create and manage a production-grade Azure AKS cluster using Cluster API.

Among other things, this involves:
* installing the Cluster API Azure Infrastructure Provider, which is the component responsible for the provisioning of infrastructure/computational resources required by Cluster API
* providing Cluster API with credentials to be able to access and change Azure cloud resources

Once this is done, we are able to provision Kubernetes clusters in Azure using Cluster API.

## Setup
To begin you must install and configure Azure CLI:
1. [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

```bash
# Set Azure values
# Replace `[...]` with your desired region
export AZURE_LOCATION=[...]
export AZURE_RESOURCE_GROUP="production"

# Replace `[...]` with your Azure Subscription ID
export AZURE_SUBSCRIPTION_ID=[...]

# Create Azure Service Principal
az ad sp create-for-rbac --role Contributor --scopes="/subscriptions/${AZURE_SUBSCRIPTION_ID}" --sdk-auth > sp.json

# Set variables based on Service Principal JSON
export AZURE_SUBSCRIPTION_ID="$(cat sp.json | jq -r .subscriptionId | tr -d '\n')"
export AZURE_CLIENT_SECRET="$(cat sp.json | jq -r .clientSecret | tr -d '\n')"
export AZURE_CLIENT_ID="$(cat sp.json | jq -r .clientId | tr -d '\n')"
export AZURE_NODE_MACHINE_TYPE="Standard_D2s_v3"
export AZURE_CLUSTER_IDENTITY_SECRET_NAME="cluster-identity-secret"
export AZURE_CLUSTER_IDENTITY_SECRET_NAMESPACE="production"
export CLUSTER_IDENTITY_NAME="cluster-identity"

# Set Feature Flag variables
export EXP_MACHINE_POOL=true
export EXP_AKS_RESOURCE_HEALTH=true

# Create Secret for azure identity creds
kubectl create secret generic "${AZURE_CLUSTER_IDENTITY_SECRET_NAME}" --from-literal=clientSecret="${AZURE_CLIENT_SECRET}"
clusterctl init --infrastructure azure

# Install ClusterAPI Provider for Azure
clusterctl init --infrastructure azure

yq --inplace ".capi.destination = \"azure\"" settings.yaml
```

## Do

```bash
# Set cluster values
export CLUSTER_NAME="production"
export WORKER_MACHINE_COUNT=3
export KUBERNETES_VERSION="v1.24.1"

# Generate Cluster Manifests
clusterctl generate cluster ${CLUSTER_NAME} --kubernetes-version ${KUBERNETES_VERSION} --flavor aks > capi/azure-aks.yaml

# Create the cluster
kubectl --namespace production apply --filename capi/azure-aks.yaml

kubectl --namespace production get Cluster
kubectl --namespace production get AzureManagedCluster
kubectl --namespace production get AzureManagedControlPlane
kubectl --namespace production get MachinePool
kubectl --namespace production get AzureManagedMachinePool



cat capi/get-kubeconfig-azure.sh

chmod +x capi/get-kubeconfig-azure.sh

./capi/get-kubeconfig-azure.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

yq --inplace \
    ".production.kubeConfig = \"$PWD/kubeconfig-prod.yaml\"" \
    settings.yaml

kubectl get nodes

kubectl create namespace production
```

## Continue the adventure

* [GitOps](../gitops/README.md)
