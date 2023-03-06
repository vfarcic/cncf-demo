# Setup Prerequisites

*Go through this document ONLY if you did NOT follow the story from the start (if you jumped straight into this chapter).*

```bash
# Watch https://youtu.be/BII6ZY2Rnlc if you are not familiar with GitHub CLI
gh repo fork vfarcic/cncf-demo --clone --remote

cd cncf-demo

# Select the fork as the default repository
gh repo set-default

# Create a Kubernetes cluster.
# If you're using a local Kubernetes cluster
#   (e.g., Rancher Desktop, Minikube, etc.), make sure that it
#   has at least 8GB of RAM and 4 CPU of memory.

kubectl create namespace production
```

## Setup GitOps

* If you prefer a solution other than Argo CD for GitOps, please go back to the [Production](prod.md) or an earlier chapter.

```bash
export REPO_URL=$(git config --get remote.origin.url)

# Install `yq` CLI from https://github.com/mikefarah/yq
# 'yq' is a lightweight and portable command-line YAML processor
yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/apps.yaml

# TODO: Double-check whether `configs.params.appResyncPeriod`
#   is still valid in argocd/helm-values.yaml
helm upgrade --install argocd argo-cd \
    --repo https://argoproj.github.io/argo-helm \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

kubectl apply --filename argocd/project.yaml

kubectl apply --filename argocd/apps.yaml

export GITOPS_APP=argocd

yq --inplace ".gitOps.app = \"$GITOPS_APP\"" settings.yaml
```

## Setup The App

* If you prefer a solution other than Kustomize for defining and packaging applications, please go back to the [Production](prod.md) or an earlier chapter.

```bash
# Execute the command that follows only if you are using Argo CD
yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    $GITOPS_APP/cncf-demo-kustomize.yaml

yq --inplace ".image = \"index.docker.io/vfarcic/cncf-demo\"" \
    settings.yaml

yq --inplace ".tag = \"v0.0.1\"" settings.yaml

yq --inplace \
    ".spec.template.spec.containers[0].image = \"index.docker.io/vfarcic/cncf-demo\"" \
    kustomize/base/deployment.yaml

cd kustomize/overlays/prod

kustomize edit set image \
    index.docker.io/vfarcic/cncf-demo=index.docker.io/vfarcic/cncf-demo:v0.0.1

cd ../../..

yq --inplace ".patchesStrategicMerge = []" \
    kustomize/overlays/prod/kustomization.yaml
```

## Setup Database

* If you prefer to manage a database in AWS, Azure, or Google Cloud, please go back to the [Production](prod.md) or an earlier chapter. The commands that follow will be using AWS without credentials so no actual AWS resources will be created.

```bash
helm repo add crossplane-stable \
    https://charts.crossplane.io/stable

helm repo update

helm upgrade --install crossplane crossplane-stable/crossplane \
    --namespace crossplane-system --create-namespace --wait

kubectl apply \
    --filename crossplane-config/provider-kubernetes-incluster.yaml

kubectl apply --filename crossplane-config/config-sql.yaml

kubectl apply \
    --filename crossplane-config/provider-aws-official.yaml

yq --inplace \
    ".resources += \"postgresql-crossplane-aws.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

yq --inplace \
    ".patchesStrategicMerge += \"deployment-crossplane-postgresql-aws.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

yq --inplace ".crossplane.destination = \"aws\"" settings.yaml
```

## Start The Chapter

* [Policies](../policies/README.md)