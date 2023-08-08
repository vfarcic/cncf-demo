# Setup PostgreSQL DB In The Dev Kubernetes With Crossplane And ytt

TODO: Intro

## Do

```bash
cat ytt/resources/postgresql-crossplane.yaml

cat ytt/resources/deployment.yaml

cat ytt/values-dev.yaml

yq --inplace ".db.enabled.crossplane.$XP_DESTINATION = true" \
    ytt/values-dev.yaml

yq --inplace ".db.insecure = true" ytt/values-dev.yaml

cat ytt/values-dev.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-dev.yaml \
    | tee yaml/dev/app.yaml

kubectl --namespace dev apply --filename yaml/dev

kubectl get managed

kubectl --namespace dev get sqlclaim

kubectl --namespace dev wait --for=condition=ready \
    sqlclaim cncf-demo --timeout=15m

curl "https://cncf-demo-dev.$DOMAIN/videos"
```

## Continue The Adventure

* [Manage DB Schema](../db-schema/README.md)
