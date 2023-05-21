#!/bin/sh
set -e

yq --inplace \
    ".production.google.projectId = \"$XP_PROJECT_ID\"" \
    settings.yaml

gcloud projects create $XP_PROJECT_ID

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

kubectl apply \
    --filename crossplane-config/provider-gcp-official.yaml

gum style --foreground 212 --border-foreground 212 --border double --margin "1 2" --padding "2 4" \
  'GKE starts with a very small control plane.' \
  '
Since a lot of CRDs were installed, GKE is likely going to detect
that its control plane is too small for it and increase its size
automatically.' \
  '
As a result, you might experience delays or errors like
"connection refused" or "TLS handshake timeout" (among others).' \
  '
So, we will wait for a while (e.g., 1h) for the control
plane nodes to be automatically changed for larger ones.' \
  '
This issue will soon be resolved and, when that happens, I will
remove this message and the sleep command that follows.' \
  '
Grab a cup of coffee and watch an episode of your favorite
series on Netflix.'

gum spin --spinner line --title "Waiting for GKE control plane nodes to resize (1h approx.)..." -- sleep 3600

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

echo "

https://console.cloud.google.com/billing/enable?project=$XP_PROJECT_ID

Open the URL and *ENABLE API*
Press any key to continue"

read NOTHING