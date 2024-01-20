# Policies With Cloud Custodian and Helm

TODO: Intro

## Do

```bash
cat apps/cncf-demo.yaml

# If Argo CD
yq --inplace ".spec.source.helm.parameters[9].value = \"3\"" \
    apps/cncf-demo.yaml

# If Flux
yq --inplace ".spec.values.replicas = 3" apps/cncf-demo.yaml



cat kustomize/overlays/prod/postgresql-crossplane-$HYPERSCALER.yaml

yq --inplace \
    ".spec.parameters.size = \"medium\"" \
    kustomize/overlays/prod/postgresql-crossplane-$HYPERSCALER.yaml

git add .

git commit -m "DB resize"

git push

kubectl --namespace production get deployment cncf-demo \
    --output jsonpath="{.spec.replicas}"

# Wait until the number of replicas increases to `3`.

custodian run --output-dir=output policies/cloud-custodian.yaml \
    --cache-period 0

kubectl --namespace production wait sqlclaim cncf-demo \
    --for=condition=ready --timeout=15m
```

## Continue The Adventure

* [Runtime Policies](../runtime-policies/README.md)
