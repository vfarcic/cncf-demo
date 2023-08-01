# Create and Manage Production Kubernetes Cluster with Crossplane

The goal here is to set up Crossplane to be able to deploy and manage Kubernetes clusters.

For this demo, we are using our existing development cluster and configuring it to be the management cluster for the production cluster that we are about to create. 

First we're installing Crossplane*, then we're adding the [Crossplane Kubernetes Provider](https://github.com/crossplane-contrib/provider-kubernetes) and Kubernetes Provider Config. The Kubernetes Provider & Provider Config let Crossplane deploy and manage Kubernetes objects on clusters that have been provisioned by Crossplane.

*You may already have Crossplane installed from the [Set Up PostgreSQL DB in the Dev Environment](manuscript/db/README.md) step from Chapter 1

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/cluster/crossplane.sh

./manuscript/cluster/crossplane.sh
```

## Which cloud provider do you use?

* [Google Cloud](crossplane-google.md)
* [AWS](crossplane-aws.md)
* [Azure](crossplane-azure.md)