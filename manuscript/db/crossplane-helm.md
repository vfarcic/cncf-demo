# Setup PostgreSQL DB In The Dev Kubernetes With Crossplane

TODO: Intro

## Do

```bash
cat helm/app/templates/postgresql-crossplane.yaml

cat helm/app/templates/deployment.yaml

cat helm/app/values.yaml

yq --inplace ".db.enabled.crossplane.$XP_DESTINATION = true" \
    helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait

# TODO: Fix the status
kubectl --namespace dev get sqlclaims

kubectl get managed

curl "https://dev.cncf-demo.$DOMAIN/videos"
```

## Continue The Adventure

[Manage DB Schema](../db-schema/story.md)
