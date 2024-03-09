# Create and Manage Production AWS EKS Cluster with Crossplane

In this section, we will create and manage a production-grade AWS EKS cluster using Crossplane.

Among other things, this involves:
* installing the Crossplane AWS Provider which creates a new Kubernetes API for every external AWS API
* creating the AWS Provider Config which provides Crossplane with credentials to be able to access and change AWS cloud resources

Once this is done, we are able to provision Kubernetes clusters in AWS using Crossplane Custom Resources. 

## Setup

* You can skip the steps in this section (Setup) if you already used Crossplane with AWS in one of the previous chapters.

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/cluster/crossplane-aws.sh

./manuscript/cluster/crossplane-aws.sh

source .env
```

## Do

```bash
cat crossplane/aws-eks.yaml

kubectl --namespace production apply \
    --filename crossplane/aws-eks.yaml

kubectl get managed

kubectl --namespace production get clusterclaims

kubectl --namespace production wait --for=condition=ready \
    clusterclaim production --timeout=30m

aws eks update-kubeconfig --region us-east-1 \
    --name production --kubeconfig kubeconfig-prod.yaml

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

yq --inplace \
    ".production.kubeConfig = \"$PWD/kubeconfig-prod.yaml\"" \
    settings.yaml

kubectl get nodes
```

## Continue the adventure

* [GitOps](../gitops/README.md)
