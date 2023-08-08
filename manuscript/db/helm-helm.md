# Setup PostgreSQL DB In The Dev Environment With Helm

TODO: Intro

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

yq --inplace ".db.enabled.helm = true" helm/app/values.yaml

cat helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait

curl "https://cncf-demo-dev.$DOMAIN/videos"

# Proceed further ONLY if the output contains
#   `relation "videos" does not exist`.
```

## Continue The Adventure

* [Manage DB Schema](../db-schema/README.md)
