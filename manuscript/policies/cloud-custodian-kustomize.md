# Policies With Cloud Custodian and Kustomize

TODO: Intro

## Do

```bash
cat kustomize/overlays/prod/deployment-scaled.yaml

yq --inplace \
    ".patchesStrategicMerge += \"deployment-scaled.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

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

The adventure will continue soon...

In the meantime... [Destroy Everything](../destroy/security.md)
