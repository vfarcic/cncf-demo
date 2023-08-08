# Manage DB Schema With SchemaHero With cdk8s

TODO: Intro

## Do

```bash
cd cdk8s

cat db.go

cat app.go

yq --inplace ".schemahero.enabled = true" app.yaml

cdk8s synth --output ../yaml/dev --validate 

cd ..

cat yaml/dev/cncf-demo.k8s.yaml

kubectl --namespace dev apply --filename yaml/dev

curl "https://cncf-demo-dev.$DOMAIN/videos"

curl -X POST "https://cncf-demo-dev.$DOMAIN/video?id=wNBG1-PSYmE&title=Kubernetes%20Policies%20And%20Governance%20-%20Ask%20Me%20Anything%20With%20Jim%20Bugwadia"

curl -X POST "https://cncf-demo-dev.$DOMAIN/video?id=VlBiLFaSi7Y&title=Scaleway%20-%20Everything%20We%20Expect%20From%20A%20Cloud%20Computing%20Service%3F"

curl "https://cncf-demo-dev.$DOMAIN/videos" | jq .
```

## Continue The Adventure

* [Develop](../develop/README.md)
