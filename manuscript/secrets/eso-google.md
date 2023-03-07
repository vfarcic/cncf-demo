# Managing Secrets From Google Cloud With External Secrets Operator (ESO)

TODO: Intro

## Setup

```bash
export XP_PROJECT_ID=$(yq ".production.google.projectId" \
  settings.yaml)

gcloud projects create $PROJECT_ID

echo https://console.cloud.google.com/marketplace/product/google/secretmanager.googleapis.com?project=$PROJECT_ID

# Open the URL and *ENABLE* the API

gcloud iam service-accounts \
    --project $PROJECT_ID \
    create external-secrets

echo -ne '{
"name": "my-fancy-db",
"endpoint": "127.0.0.1:8200",
"username": "jdoe",
"password": "YouWillNeverFindOut",
"port": 8200
}' | gcloud secrets \
    --project $PROJECT_ID \
    create a-team-postgresql --data-file=-

gcloud secrets \
    --project $PROJECT_ID \
    add-iam-policy-binding a-team-postgresql \
    --member "serviceAccount:external-secrets@$PROJECT_ID.iam.gserviceaccount.com" \
    --role "roles/secretmanager.secretAccessor"

gcloud iam service-accounts \
    --project $PROJECT_ID \
    keys create account.json \
    --iam-account=external-secrets@$PROJECT_ID.iam.gserviceaccount.com

kubectl create namespace a-team

kubectl --namespace external-secrets \
    create secret generic gcp \
    --from-file=credentials=account.json

cat secret-store.yaml \
    | sed -e "s@projectID: .*@projectID: $PROJECT_ID@" \
    | tee secret-store.yaml
```

## Continue The Adventure

[TODO:](TODO:)
