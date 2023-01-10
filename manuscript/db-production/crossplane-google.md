# Setup PostgreSQL DB In The Production Environment With Crossplane In Google Cloud

TODO: Intro

## Setup

```bash
echo "https://console.cloud.google.com/apis/library/sqladmin.googleapis.com?project=$XP_PROJECT_ID"

# Open the URL and *ENABLE API*

kubectl --namespace crossplane-system \
    create secret generic gcp-creds \
    --from-file creds=./gcp-creds.json

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
cat argocd/cncf-demo-db-$XP_DESTINATION.yaml

cp argocd/cncf-demo-db-$XP_DESTINATION.yaml \
    apps/cncf-demo-db.yaml

git add .

git commit -m "App DB"

git push

kubectl get managed

kubectl --namespace dev get sqlclaims

# Wait until it is `READY`

curl "https://cncf-demo-dev.$DOMAIN/videos"

# TODO: Add SchemaHero
```

## Continue The Adventure

[TODO:](TODO:)
