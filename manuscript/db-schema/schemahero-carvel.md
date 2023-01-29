# Manage DB Schema With SchemaHero With Carvel ytt

TODO: Intro

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

curl "https://cncf-demo-dev.$DOMAIN/videos"

curl -X POST "https://cncf-demo-dev.$DOMAIN/video?id=wNBG1-PSYmE&title=Kubernetes%20Policies%20And%20Governance%20-%20Ask%20Me%20Anything%20With%20Jim%20Bugwadia"

curl -X POST "https://cncf-demo-dev.$DOMAIN/video?id=VlBiLFaSi7Y&title=Scaleway%20-%20Everything%20We%20Expect%20From%20A%20Cloud%20Computing%20Service%3F"

curl "https://cncf-demo-dev.$DOMAIN/videos" | jq .
```

## Continue The Adventure

[Develop](../develop/README.md)
