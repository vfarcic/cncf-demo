# Manage DB Schema With SchemaHero With Helm

TODO: Intro

## Do

```bash
# Execute only if the DB was created with Crossplane
export SCHEMA_FILE=postgresql-crossplane-schema-$XP_DESTINATION.yaml

# Execute only if the DB was NOT created with Crossplane
export SCHEMA_FILE=postgresql-schema.yaml

cat kustomize/overlays/dev/$SCHEMA_FILE

yq --inplace ".resources += \"$SCHEMA_FILE\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/kustomization.yaml

# Execute only if the DB was created with Crossplane
kubectl --namespace dev apply --kustomize kustomize/overlays/dev

# Execute only if the DB was NOT created with Crossplane
kubectl --namespace dev kustomize --enable-helm \
    kustomize/overlays/dev \
    | kubectl --namespace dev apply --filename -

curl "https://cncf-demo-dev.$DOMAIN/videos"

curl -X POST "https://cncf-demo-dev.$DOMAIN/video?id=wNBG1-PSYmE&title=Kubernetes%20Policies%20And%20Governance%20-%20Ask%20Me%20Anything%20With%20Jim%20Bugwadia"

curl -X POST "https://cncf-demo-dev.$DOMAIN/video?id=VlBiLFaSi7Y&title=Scaleway%20-%20Everything%20We%20Expect%20From%20A%20Cloud%20Computing%20Service%3F"

curl "https://cncf-demo-dev.$DOMAIN/videos" | jq .
```

## Continue The Adventure

* [Develop](../develop/README.md)
