# Managing Secrets From Google Cloud With External Secrets Operator (ESO)

TODO: Intro

## Setup

```bash
export XP_PROJECT_ID=$(yq ".production.google.projectId" \
  settings.yaml)

echo https://console.cloud.google.com/marketplace/product/google/secretmanager.googleapis.com?project=$XP_PROJECT_ID

# Open the URL and *ENABLE* the API

gcloud iam service-accounts --project $XP_PROJECT_ID \
    create external-secrets

echo -ne '{"password": "YouWillNeverFindOut"}' \
    | gcloud secrets --project $XP_PROJECT_ID \
    create production-postgresql --data-file=-

gcloud secrets --project $XP_PROJECT_ID \
    add-iam-policy-binding production-postgresql \
    --member "serviceAccount:external-secrets@$XP_PROJECT_ID.iam.gserviceaccount.com" \
    --role "roles/secretmanager.secretAccessor"

gcloud iam service-accounts \
    --project $XP_PROJECT_ID \
    keys create account.json \
    --iam-account=external-secrets@$XP_PROJECT_ID.iam.gserviceaccount.com

kubectl --namespace external-secrets \
    create secret generic google \
    --from-file=credentials=account.json

yq --inplace \
    ".spec.provider.gcpsm.projectID = \"$XP_PROJECT_ID\"" \
    eso/secret-store-google.yaml

cp eso/secret-store-google.yaml infra/.

git add .

git commit -m "Secret Store"

git push

kubectl --namespace external-secrets get clustersecretstores

# Wait until the ClusterSecretStore appears
```

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel](carvel.md)
* [cdk8s](cdk8s.md)
