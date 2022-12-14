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
cat helm/app/templates/schemahero.yaml

cat helm/app/values.yaml

yq --inplace ".schemahero.enabled = true" helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev

curl "https://dev.cncf-demo.$DOMAIN/videos"

curl -X POST "https://dev.cncf-demo.$DOMAIN/video?id=wNBG1-PSYmE&title=Kubernetes%20Policies%20And%20Governance%20-%20Ask%20Me%20Anything%20With%20Jim%20Bugwadia"

curl -X POST "https://dev.cncf-demo.$DOMAIN/video?id=VlBiLFaSi7Y&title=Scaleway%20-%20Everything%20We%20Expect%20From%20A%20Cloud%20Computing%20Service%3F"

curl "https://dev.cncf-demo.$DOMAIN/videos" | jq .
```

## Continue The Adventure

[TODO:](TODO:)
