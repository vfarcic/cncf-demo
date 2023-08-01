
# Create and Manage Production Kubernetes Cluster with ClusterAPI

To get started with Cluster API, you first need to create a management cluster. Here we're creating a local [Kind](https://kind.sigs.k8s.io/) cluster and installing Cluster API into it, as well as CLIs for both Kubernetes (Kubectl) and Cluster API (Clusterctl).

## Setup

First you need to install:
1. [Docker](https://www.docker.com/)
2. [Kubectl](https://kubernetes.io/docs/tasks/tools/)
2. [Clusterctl](https://cluster-api.sigs.k8s.io/user/quick-start.html#install-clusterctl)
3. [Kind](https://kind.sigs.k8s.io/docs/user/quick-start#installation)

```bash
# Export environment variables
export CLUSTER_TOPOLOGY=true
export EXP_CLUSTER_RESOURCE_SET=true
export EXP_MACHINE_POOL=true

# Install Core ClusterAPI
clusterctl init
```

## Which cloud provider do you use?

* [Google Cloud](capi-google.md)
* [AWS](capi-aws.md)
* [Azure](capi-azure.md)
