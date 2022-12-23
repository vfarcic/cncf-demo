# Setup PostgreSQL DB In The Dev Kubernetes With Crossplane

TODO: Intro

## Do

```bash
cat kustomize/overlays/dev/postgresql-crossplane-$XP_DESTINATION.yaml

yq --inplace ".resources += \"postgresql-crossplane-$XP_DESTINATION.yaml\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/deployment-crossplane-postgresql-$XP_DESTINATION.yaml

yq --inplace ".patchesStrategicMerge = []" \
    kustomize/overlays/dev/kustomization.yaml

yq --inplace ".patchesStrategicMerge += \"deployment-crossplane-postgresql-$XP_DESTINATION.yaml\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/kustomization.yaml

kubectl --namespace dev apply --kustomize kustomize/overlays/dev

# TODO: Remove
# If Google Cloud
# kubectl get databaseinstances.sql.gcp.upbound.io,users.sql.gcp.upbound.io,databases.postgresql.sql.crossplane.io,objects.kubernetes.crossplane.io

kubectl get managed

kubectl --namespace dev get sqlclaims

# Wait until it is `READY`

curl "https://dev.cncf-demo.$DOMAIN/videos"
```

## Continue The Adventure

[Manage DB Schema](../db-schema/story.md)
