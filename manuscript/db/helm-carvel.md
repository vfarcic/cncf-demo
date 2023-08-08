# Setup PostgreSQL DB In The Dev Environment With Helm And Carvel ytt

TODO: Intro

## Do

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo update

cat helm/postgresql/values.yaml

helm template postgresql bitnami/postgresql --version 12.1.2 \
    --namespace dev \
    --values helm/postgresql/values.yaml \
    | tee yaml/dev/postgresql.yaml

cat ytt/resources/deployment.yaml

cat ytt/values-dev.yaml

yq --inplace ".db.enabled.helm = true" ytt/values-dev.yaml

cat ytt/values-dev.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-dev.yaml \
    | tee yaml/dev/app.yaml

kubectl --namespace dev apply --filename yaml/dev

curl "https://cncf-demo-dev.$DOMAIN/videos"

# Proceed further ONLY if the output contains
#   `relation "videos" does not exist`.
```

## Continue The Adventure

* [Manage DB Schema](../db-schema/README.md)
