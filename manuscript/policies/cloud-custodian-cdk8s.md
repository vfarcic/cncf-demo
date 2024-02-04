# Policies With Cloud Custodian and cdk8s

TODO: Intro

## Do

```bash
cat cdk8s/app-prod.yaml

yq --inplace ".replicas = 3" cdk8s/app-prod.yaml

yq --inplace ".db.size = \"medium\"" cdk8s/app-prod.yaml

cd cdk8s

ENVIRONMENT=prod cdk8s synth --output ../yaml/prod --validate

cd ..

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
