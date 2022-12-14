# Manage DB Schema With SchemaHero With Helm

TODO: Intro

## Setup

* Install `krew` from https://krew.sigs.k8s.io/docs/user-guide/setup/install

```bash
kubectl krew install schemahero

kubectl schemahero install
```

## Do

```bash
# Execute only if the DB was created with Crossplane
export SCHEMA_FILE=postgresql-crossplane-schema-$XP_DESTINATION.yaml

# Execute only if the DB was NOT created with Crossplane
export SCHEMA_FILE=postgresql-schema.yaml

cat kustomize/base/$SCHEMA_FILE

yq --inplace ".resources += \"$SCHEMA_FILE\"" \
    kustomize/base/kustomization.yaml

cat kustomize/base/kustomization.yaml

kubectl --namespace dev kustomize --enable-helm \
    kustomize/overlays/dev | kubectl apply --filename -

curl "https://dev.cncf-demo.$DOMAIN/videos"

curl -X POST "https://dev.cncf-demo.$DOMAIN/video?id=wNBG1-PSYmE&title=Kubernetes%20Policies%20And%20Governance%20-%20Ask%20Me%20Anything%20With%20Jim%20Bugwadia"

curl -X POST "https://dev.cncf-demo.$DOMAIN/video?id=VlBiLFaSi7Y&title=Scaleway%20-%20Everything%20We%20Expect%20From%20A%20Cloud%20Computing%20Service%3F"

curl "https://dev.cncf-demo.$DOMAIN/videos" | jq .
```

## Continue The Adventure

[Develop](../develop/story.md)
