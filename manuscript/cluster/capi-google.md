# Create And Manage Production Google GKE Cluster With ClusterAPI

In this section, we will create and manage a production-grade Google Cloud GKE cluster using Cluster API.

Among other things, this involves:
* installing the Cluster API GCP Infrastructure Provider, which is the component responsible for the provisioning of infrastructure/computational resources required by Cluster API
* providing Cluster API with credentials to be able to access and change Google Cloud resources

Once this is done, we are able to provision Kubernetes clusters in Google Cloud using Cluster API.

## Setup

```bash
# Export Environment Variables
export CLUSTER_TOPOLOGY=true
export EXP_CLUSTER_RESOURCE_SET=true
export EXP_MACHINE_POOL=true
export EXP_CAPG_GKE=true

# Create the base64 encoded credentials by catting your credentials json.
# This command uses your environment variables and encodes
# them in a value to be stored in a Kubernetes Secret.
# Replace `[...]` with the path to your gcp credentials json file.
export GCP_B64ENCODED_CREDENTIALS=$( cat [...] | base64 | tr -d '\n' )

# Install ClusterAPI Provider for Google
clusterctl init --infrastructure gcp

yq --inplace ".capi.destination = \"google\"" settings.yaml
```

## Do

```bash
# Set variables

# Replace `[...]` with your desired
export GCP_REGION="[...]"
# Replace `[...]` with your desired
export GCP_PROJECT="[...]"

# Replace `[...]` with your desired
export GCP_NETWORK_NAME=[...]
# Set cluster name
export CLUSTER_NAME=production
# Generate cluster manifest
clusterctl generate cluster production --flavor gke --worker-machine-count=3 --kubernetes-version v1.24.1 --worker-machine-count=3 > capi/google-gke.yaml

# Create the cluster
kubectl --namespace production apply --filename capi/google-gke.yaml

kubectl --namespace production get Cluster
kubectl --namespace production get GCPManagedCluster
kubectl --namespace production get GCPManagedControlPlane
kubectl --namespace production get MachinePool
kubectl --namespace production get GCPManagedMachinePool

cat capi/get-kubeconfig-google.sh

chmod +x capi/get-kubeconfig-google.sh

./capi/get-kubeconfig-google.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

yq --inplace \
    ".production.kubeConfig = \"$PWD/kubeconfig-prod.yaml\"" \
    settings.yaml

kubectl get nodes

kubectl create namespace production
```

## Continue the Adventure

* [GitOps](../gitops/README.md)
