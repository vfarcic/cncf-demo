#!/bin/sh
set -e

yq --inplace \
    ".production.google.projectId = \"$XP_PROJECT_ID\"" \
    settings.yaml

gcloud projects create $XP_PROJECT_ID

echo "

https://console.cloud.google.com/billing/enable?project=$XP_PROJECT_ID

Open the URL and *ENABLE API*
Press any key to continue"

read NOTHING

echo "

https://console.cloud.google.com/apis/library/sqladmin.googleapis.com?project=$XP_PROJECT_ID

Open the URL and *ENABLE API*
Press any key to continue"

read NOTHING

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

kubectl wait --for=condition=healthy provider.pkg.crossplane.io \
    --all --timeout=300s

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
