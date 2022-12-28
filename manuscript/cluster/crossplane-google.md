# Create And Manage Production Google GKE Cluster With Crossplane

TODO: Intro

## Setup

```bash
echo https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$XP_PROJECT_ID

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
```

## Do

```bash
export XP_DESTINATION=google

cat crossplane/google-gke.yaml

kubectl --namespace production apply \
    --filename crossplane/google-gke.yaml

kubectl get managed

kubectl --namespace production get clusterclaims

cat crossplane/get-kubeconfig-$XP_DESTINATION.sh

./crossplane/get-kubeconfig-$XP_DESTINATION.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

kubectl get nodes
```

## Continue The Adventure

[GitOps](../gitops/story.md)
