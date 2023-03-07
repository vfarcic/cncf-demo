# Setup PostgreSQL DB In Google Cloud With Crossplane

TODO: Intro

## Setup

```bash
export XP_PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

yq --inplace \
    ".production.google.projectId = \"$XP_PROJECT_ID\"" \
    settings.yaml

gcloud projects create $XP_PROJECT_ID

echo "https://console.cloud.google.com/apis/library/sqladmin.googleapis.com?project=$XP_PROJECT_ID"

# Open the URL and *ENABLE API*

export SA_NAME=devops-toolkit

export SA="${SA_NAME}@${XP_PROJECT_ID}.iam.gserviceaccount.com"

gcloud iam service-accounts create $SA_NAME --project $XP_PROJECT_ID

export ROLE=roles/admin

gcloud projects add-iam-policy-binding --role $ROLE $XP_PROJECT_ID \
    --member serviceAccount:$SA

gcloud iam service-accounts keys create gcp-creds.json \
    --project $XP_PROJECT_ID --iam-account $SA

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

export XP_DESTINATION=google
```

## How Did You Define Your App?

* [Helm](crossplane-helm.md)
* [Kustomize](crossplane-kustomize.md)
* [Carvel](crossplane-carvel.md)
* [cdk8s](crossplane-cdk8s.md)