# Create And Manage Production Google Cloud GKE Cluster With Crossplane

TODO: Intro

## Setup

* You can skip the steps in this section (the Setup) if you already used Crossplane with Google in one of the previous chapters.

```bash
export XP_PROJECT_ID=$(yq ".production.google.projectId" \
  settings.yaml)

echo "https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$XP_PROJECT_ID"

# Open the URL and *ENABLE* the API

kubectl --namespace crossplane-system \
    create secret generic gcp-creds \
    --from-file creds=./gcp-creds.json

kubectl apply \
    --filename crossplane-config/provider-gcp-official.yaml

kubectl get pkgrev

# Wait until all the packages are healthy

echo "apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  projectID: $XP_PROJECT_ID
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gcp-creds
      key: creds" \
    | kubectl apply --filename -

yq --inplace ".crossplane.destination = \"google\"" settings.yaml
```

## Do

```bash
cat crossplane/google-gke.yaml

kubectl --namespace production apply \
    --filename crossplane/google-gke.yaml

# TODO: Remove
# kubectl get cluster.container.gcp.upbound.io,nodepool.container.gcp.upbound.io,release.helm.crossplane.io,object.kubernetes.crossplane.io

kubectl get managed

kubectl --namespace production get claim

cat crossplane/get-kubeconfig-google.sh

chmod +x crossplane/get-kubeconfig-google.sh

./crossplane/get-kubeconfig-google.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

yq --inplace \
  ".production.kubeConfig = \"$PWD/kubeconfig-prod.yaml\"" \
    settings.yaml

kubectl get nodes
```

## Continue The Adventure

[GitOps](../gitops/README.md)
