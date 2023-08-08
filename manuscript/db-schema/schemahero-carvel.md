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

curl -X POST "https://cncf-demo-dev.$DOMAIN/video?id=1&title=This%20is%20a%20great%20video"

curl -X POST "https://cncf-demo-dev.$DOMAIN/video?id=2&title=This%20is%20an%20even%20better%20video"

curl "https://cncf-demo-dev.$DOMAIN/videos" | jq .
```

## Continue The Adventure

* [Develop](../develop/README.md)
