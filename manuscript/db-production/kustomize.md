# Setup PostgreSQL DB In The Production Environment With Crossplane And Kustomize

TODO: Intro

## Setup

```bash
export DOMAIN=$(yq ".production.domain" settings.yaml)
```

## Do

```bash
cat kustomize/overlays/prod/postgresql-crossplane-$XP_DESTINATION.yaml

yq --inplace ".resources += \"postgresql-crossplane-$XP_DESTINATION.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

yq --inplace ".resources += \"postgresql-crossplane-secret-$XP_DESTINATION.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

cat kustomize/overlays/prod/deployment-crossplane-postgresql-$XP_DESTINATION.yaml

yq --inplace ".patchesStrategicMerge = []" \
    kustomize/overlays/prod/kustomization.yaml

yq --inplace ".patchesStrategicMerge += \"deployment-crossplane-postgresql-$XP_DESTINATION.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

cat kustomize/overlays/prod/postgresql-crossplane-schema-$XP_DESTINATION.yaml

# Execute the command that follows ONLY if you did NOT follow
#   the story from the start (if you jumped straight into this
#   chapter).
yq --inplace ".resources += \"postgresql-crossplane-schema-$XP_DESTINATION.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

cat kustomize/overlays/prod/kustomization.yaml

git add .

git commit -m "App DB"

git push

kubectl get managed

kubectl --namespace production get claim

# Wait until it is `READY`

# If you chose to use `nip.io` instead of a "real" domain,
#   replace `https` with `http`.
curl "https://cncf-demo.$DOMAIN/videos"

# If you chose to use `nip.io` instead of a "real" domain,
#   replace `https` with `http`.
curl -X POST "https://cncf-demo.$DOMAIN/video?id=wNBG1-PSYmE&title=Kubernetes%20Policies%20And%20Governance%20-%20Ask%20Me%20Anything%20With%20Jim%20Bugwadia"

# If you chose to use `nip.io` instead of a "real" domain,
#   replace `https` with `http`.
curl -X POST "https://cncf-demo.$DOMAIN/video?id=VlBiLFaSi7Y&title=Scaleway%20-%20Everything%20We%20Expect%20From%20A%20Cloud%20Computing%20Service%3F"

# If you chose to use `nip.io` instead of a "real" domain,
#   replace `https` with `http`.
curl "https://cncf-demo.$DOMAIN/videos" | jq .
```

## Continue The Adventure

Continue to [Admission Controller Policies](../policies/README.md) (first episode of the next season) or [destroy everything](../destroy/production.md)
