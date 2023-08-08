# Setup PostgreSQL DB In The Dev Kubernetes With Crossplane

TODO: Intro

## Do

```bash
cat helm/app/templates/postgresql-crossplane.yaml

cat helm/app/templates/deployment.yaml

cat helm/app/values.yaml

yq --inplace ".db.enabled.crossplane.$XP_DESTINATION = true" \
    helm/app/values.yaml

yq --inplace ".db.insecure = true" helm/app/values.yaml

cat helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev

kubectl get managed

kubectl --namespace dev get sqlclaims

# Wait until it is `READY`

curl "https://cncf-demo-dev.$DOMAIN/videos"

# Proceed further ONLY if the output contains
#   `relation "videos" does not exist`.
```

## Continue The Adventure

* [Manage DB Schema](../db-schema/README.md)
