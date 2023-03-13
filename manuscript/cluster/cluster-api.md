
# Create And Manage Production Kubernetes Cluster With ClusterAPI

TODO: Intro

## Setup

First you need to install:
1. [Docker](https://www.docker.com/)
2. [Kubectl](https://kubernetes.io/docs/tasks/tools/)
2. [Clusterctl](https://cluster-api.sigs.k8s.io/user/quick-start.html#install-clusterctl)
3. [Kind](https://kind.sigs.k8s.io/docs/user/quick-start#installation)
```bash
# Create the bootstrap cluster
kind create cluster

# Export environment variables
export CLUSTER_TOPOLOGY=true
export EXP_CLUSTER_RESOURCE_SET=true
export EXP_MACHINE_POOL=true

# Install Core ClusterAPI
clusterctl init

```

## Which Cloud Provider Do You Use?

* [Google Cloud](capi-google.md)
* [AWS](capi-aws.md)
* [Azure](capi-azure.md)
