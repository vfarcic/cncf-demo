# Create And Manage Production Kubernetes Cluster With Crossplane

The goal here is to set up Crossplane to be able to deploy and manage Kubernetes clusters.

For this demo, we are using our existing development cluster and configuring it to be the management cluster for the production cluster that we are about to create. 

First we're installing Crossplane*, then we're adding the [Crossplane Kubernetes Provider](https://github.com/crossplane-contrib/provider-kubernetes) and Kubernetes Provider Config. The Kubernetes Provider & Provider Config let Crossplane deploy and manage Kubernetes objects on clusters that have been provisioned by Crossplane.

*You may already have Crossplane installed from the [Set Up PostgreSQL DB in the Dev Environment](manuscript/db/README.md) step from Chapter 1

## Setup

```bash
helm repo add crossplane-stable \
    https://charts.crossplane.io/stable

helm repo update

helm upgrade --install crossplane crossplane-stable/crossplane \
    --namespace crossplane-system --create-namespace --wait

kubectl apply \
    --filename crossplane-config/provider-kubernetes-incluster.yaml

kubectl apply --filename crossplane-config/config-k8s.yaml
```

## Which Cloud Provider Do You Use?

* [Google Cloud](crossplane-google.md)
* [AWS](crossplane-aws.md)
* [Azure](crossplane-azure.md)