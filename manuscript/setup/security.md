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

## Setup Google Cloud

* Please execute the commands in this section only if you are using Google Cloud as the destination.

```bash
kubectl create namespace crossplane-system

export PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

yq --inplace \
    ".production.google.projectId = \"$PROJECT_ID\"" \
    settings.yaml

gcloud projects create $PROJECT_ID

echo "https://console.cloud.google.com/apis/library/sqladmin.googleapis.com?project=$PROJECT_ID"

# Open the URL and *ENABLE API*

export SA_NAME=devops-toolkit

export SA="${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

gcloud iam service-accounts create $SA_NAME --project $PROJECT_ID

export ROLE=roles/admin

gcloud projects add-iam-policy-binding --role $ROLE $PROJECT_ID \
    --member serviceAccount:$SA

gcloud iam service-accounts keys create gcp-creds.json \
    --project $PROJECT_ID --iam-account $SA

kubectl --namespace crossplane-system \
    create secret generic gcp-creds \
    --from-file creds=./gcp-creds.json

echo "apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  projectID: $PROJECT_ID
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gcp-creds
      key: creds" \
    | kubectl apply --filename -

export DESTINATION=google

yq --inplace ".crossplane.destination = \"$DESTINATION\"" \
    settings.yaml
```

## Setup AWS

* Please execute the commands in this section only if you are using AWS as the destination.

```bash
# TODO:
```

## Setup Azure

* Please execute the commands in this section only if you are using Azure as the destination.

```bash
# TODO:
```

## Setup Database

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
    --filename crossplane-config/provider-$DESTINATION-official.yaml

yq --inplace \
    ".resources += \"postgresql-crossplane-$DESTINATION.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

yq --inplace ".resources += \"postgresql-crossplane-secret-$DESTINATION.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

yq --inplace \
    ".patchesStrategicMerge += \"deployment-crossplane-postgresql-$DESTINATION.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

yq --inplace ".resources += \"postgresql-crossplane-schema-$DESTINATION.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml
```

## Setup Dabase Schema

```bash
cp argocd/schema-hero.yaml infra/.

git add .

git commit -m "SchemaHero"

git push
```

## Start The Chapter

* [Policies](../policies/README.md)