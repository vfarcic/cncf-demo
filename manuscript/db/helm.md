# Setup PostgreSQL DB In The Dev Environment With Helm

TODO: Intro

## Setup

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo update
```

## Do

```bash
helm upgrade --install cncf-demo-db bitnami/postgresql \
    --namespace dev --create-namespace \
    --values helm/postgresql/values.yaml --wait

cat helm/app/templates/deployment.yaml

cat helm/app/values.yaml

yq --inplace ".db.enabled = true" helm/app/values.yaml

yq --inplace ".db.name = \"cncf-demo-db\"" helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait

curl -X POST "https://dev.cncf-demo.$DOMAIN/video?id=wNBG1-PSYmE&title=Kubernetes%20Policies%20And%20Governance%20-%20Ask%20Me%20Anything%20With%20Jim%20Bugwadia"
```

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
yq --inplace ".db.enabled = false" helm/app/values.yaml

yq --inplace ".db.name = \"my-db\"" helm/app/values.yaml
```

## Continue The Adventure

[TODO:](TODO:)