# Manage DB Schema With SchemaHero With Helm

TODO: Intro

## Do

```bash
cat helm/app/templates/schemahero.yaml

cat helm/app/values.yaml

yq --inplace ".schemahero.enabled = true" helm/app/values.yaml

cat helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev

curl "https://cncf-demo-dev.$DOMAIN/videos"

curl -X POST "https://cncf-demo-dev.$DOMAIN/video?id=wNBG1-PSYmE&title=Kubernetes%20Policies%20And%20Governance%20-%20Ask%20Me%20Anything%20With%20Jim%20Bugwadia"

curl -X POST "https://cncf-demo-dev.$DOMAIN/video?id=VlBiLFaSi7Y&title=Scaleway%20-%20Everything%20We%20Expect%20From%20A%20Cloud%20Computing%20Service%3F"

curl "https://cncf-demo-dev.$DOMAIN/videos" | jq .
```

## Continue The Adventure

* [Develop](../develop/README.md)
