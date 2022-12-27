# Manage DB Schema With SchemaHero With Carvel ytt

TODO: Intro

## Setup

* Install `krew` from https://krew.sigs.k8s.io/docs/user-guide/setup/install

```bash
kubectl krew install schemahero

kubectl schemahero install
```

## Do

```bash
cat ytt/resources/schemahero.yaml

cat ytt/schema.yaml

yq --inplace ".schemahero.enabled = true" ytt/schema.yaml

cat ytt/schema.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-dev.yaml \
    | tee yaml/dev/app.yaml

kubectl --namespace dev apply --filename yaml/dev

curl "https://dev.cncf-demo.$DOMAIN/videos"

curl -X POST "https://dev.cncf-demo.$DOMAIN/video?id=wNBG1-PSYmE&title=Kubernetes%20Policies%20And%20Governance%20-%20Ask%20Me%20Anything%20With%20Jim%20Bugwadia"

curl -X POST "https://dev.cncf-demo.$DOMAIN/video?id=VlBiLFaSi7Y&title=Scaleway%20-%20Everything%20We%20Expect%20From%20A%20Cloud%20Computing%20Service%3F"

curl "https://dev.cncf-demo.$DOMAIN/videos" | jq .
```

## Continue The Adventure

[Develop](../develop/story.md)
