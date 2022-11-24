# Setup PostgreSQL DB In The Dev Environment With Helm

TODO: Intro

## Setup

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo update
```

## Do

```bash
yq --inplace ".dependencies[0].name = \"postgresql\"" \
    helm/app/Chart.yaml

yq --inplace ".dependencies[0].version = \"12.1.2\"" \
    helm/app/Chart.yaml

yq --inplace \
    ".dependencies[0].repository = \"https://charts.bitnami.com/bitnami\"" \
    helm/app/Chart.yaml

helm dep up helm/app

cat helm/app/templates/deployment.yaml

cat helm/app/values.yaml

yq --inplace ".db.enabled = true" helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait

curl "https://dev.cncf-demo.$DOMAIN/videos"
```

## Continue The Adventure

[Manage DB Schema](../db-schema/story.md)

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
yq --inplace ".db.enabled = false" helm/app/values.yaml

yq --inplace ".db.name = \"my-db\"" helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait
```
