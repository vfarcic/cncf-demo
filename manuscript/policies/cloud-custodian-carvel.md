# Policies With Cloud Custodian and Carvel ytt

TODO: Intro

## Do

```bash
cat ytt/values-prod.yaml

yq --inplace ".replicas = 3" ytt/values-prod.yaml

yq --inplace ".db.size = \"medium\"" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "Replicas & DB resize"

git push

kubectl --namespace production get deployment cncf-demo \
    --output jsonpath="{.spec.replicas}"

# Wait until the number of replicas increases to `3`.

custodian run --output-dir=output policies/cloud-custodian.yaml \
    --cache-period 0

deactivate

kubectl --namespace production wait sqlclaim cncf-demo \
    --for=condition=ready --timeout=15m
```

## Continue The Adventure

* [Runtime Policies](../runtime-policies/README.md)
