# Setup PostgreSQL DB In The Dev Kubernetes With Crossplane

TODO: Intro

## Do

```bash
cat kustomize/overlays/dev/postgresql-crossplane-local.yaml

yq --inplace ".resources += \"postgresql-crossplane-local.yaml\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/deployment-crossplane-postgresql.yaml

yq --inplace ".patchesStrategicMerge = []" \
    kustomize/overlays/dev/kustomization.yaml

yq --inplace ".patchesStrategicMerge += \"deployment-crossplane-postgresql.yaml\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/kustomization.yaml

kubectl --namespace dev apply --kustomize kustomize/overlays/dev

# TODO: Fix the status
kubectl --namespace dev get sqlclaims

curl "https://dev.cncf-demo.$DOMAIN/videos"
```

## Continue The Adventure

[Manage DB Schema](../db-schema/story.md)
