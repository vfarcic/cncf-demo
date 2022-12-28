# Create And Manage Production Google GKE Cluster With Crossplane

TODO: Intro

## Setup

```bash
echo $XP_PROJECT_ID

# Execute the command that follows ONLY if `$XP_PROJECT_ID` is empty
export XP_PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

# Execute the command that follows ONLY if `$XP_PROJECT_ID` is empty
gcloud projects create $XP_PROJECT_ID

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
TODO:
```

## Continue The Adventure

[TODO:](TODO:)