# Setup Prerequisites

*Go through this document ONLY if you did NOT follow the story from the start (if you jumped straight into this chapter).*

```bash
gh repo fork vfarcic/cncf-demo --clone --remote

cd cncf-demo

gh repo set-default

devbox shell

eval "$(teller sh)"

eksctl create cluster --config-file eksctl/config-small.yaml \
    --kubeconfig kubeconfig.yaml

export KUBECONFIG=$PWD/kubeconfig.yaml

kubectl create namespace production

alias curl="curl --insecure"

export REPO_URL=$(git config --get remote.origin.url)

yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/apps.yaml

yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/cncf-demo-kustomize.yaml

yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/cncf-demo-ytt.yaml

yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/cncf-demo-cdk8s.yaml

yq --inplace ".spec.fetch[0].git.url = \"$REPO_URL\"" \
    kapp-controller/apps.yaml

yq --inplace ".spec.fetch[0].git.url = \"$REPO_URL\"" \
    kapp-controller/cncf-demo-ytt.yaml

yq --inplace ".spec.fetch[0].git.url = \"$REPO_URL\"" \
    kapp-controller/cncf-demo-kustomize.yaml

yq --inplace ".spec.fetch[0].git.url = \"$REPO_URL\"" \
    kapp-controller/cncf-demo-cdk8s.yaml

export IMAGE=index.docker.io/vfarcic/cncf-demo

export TAG=v0.0.1
```

## Setup CAPI

```sh
export CLUSTER_TOPOLOGY=true
export EXP_CLUSTER_RESOURCE_SET=true
export EXP_MACHINE_POOL=true

clusterctl init
```

* Install [clusterawsadm CLI](https://cluster-api-aws.sigs.k8s.io/topics/using-clusterawsadm-to-fulfill-prerequisites.html#using-clusterawsadm-to-fulfill-prerequisites)

```sh
export AWS_REGION=us-east-1

clusterawsadm bootstrap iam create-cloudformation-stack --config capi-config/capa-iam-config.yaml

# aws ec2 import-key-pair --key-name default --public-key-material "$(cat ~/.ssh/id_rsa.pub)"

export CLUSTER_TOPOLOGY=true

export EXP_CLUSTER_RESOURCE_SET=true

export EXP_MACHINE_POOL=true

export CAPA_EKS_IAM=true

export CAPA_EKS_ADD_ROLES=true

export EXP_EKS_FARGATE=true

export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile)

clusterctl init --infrastructure aws

export AWS_SSH_KEY_NAME=default

export AWS_NODE_MACHINE_TYPE=t3.large

clusterctl generate cluster production \
    --flavor eks-managedmachinepool-vpccni \
    --kubernetes-version v1.29.0 --worker-machine-count 2 \
    --target-namespace production \
    | tee capi/aws-eks.yaml

kubectl apply --filename capi/aws-eks.yaml
```

## Setup Crossplane

```sh
./manuscript/cluster/crossplane.sh

./manuscript/cluster/crossplane-aws.sh

source .env

kubectl --namespace production apply \
    --filename crossplane/aws-eks-small.yaml
```

## Setup CAPI

```sh
kubectl --namespace production get \
    clusters,awsmanagedclusters,awsmanagedcontrolplanes,machinepools,awsmanagedmachinepools

# Wait until all the resources are available

./capi/get-kubeconfig-aws.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

kubectl get nodes

helm upgrade --install argocd argo-cd \
    --repo https://argoproj.github.io/argo-helm \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait
```

## Setup Crossplane

```sh
export KUBECONFIG=$PWD/kubeconfig.yaml

crossplane beta trace clusterclaim production --namespace production

# Wait until all the resources are available

aws eks update-kubeconfig --region us-east-1 \
    --name production --kubeconfig kubeconfig-prod.yaml

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

kubectl get nodes

helm upgrade --install argocd argo-cd \
    --repo https://argoproj.github.io/argo-helm \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait
```

## Misc

```sh
export KUBECONFIG=$PWD/kubeconfig.yaml
```

## What is your choice?

* [Cluster API](../cluster/rejekts-paris-cluster-api.md)
* [Crossplane](../cluster/rejekts-paris-crossplane.md)