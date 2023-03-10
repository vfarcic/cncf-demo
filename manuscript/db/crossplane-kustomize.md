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
# If Azure
# kubectl get resourcegroup.azure.upbound.io,server.dbforpostgresql.azure.upbound.io,firewallrule.dbforpostgresql.azure.upbound.io,database.postgresql.sql.crossplane.io

kubectl get managed

kubectl --namespace dev get sqlclaims

# Wait until it is `READY`

curl "https://cncf-demo-dev.$DOMAIN/videos"

# Proceed further ONLY if the output contains
#   `relation "videos" does not exist`.
```

## Continue The Adventure

The Adventure will continue soon...