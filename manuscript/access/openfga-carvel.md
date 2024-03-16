# Access Authorization With OpenFGA and Carvel ytt

TODO: Intro

## Do

```bash
yq --inplace ".ingress.host = \"cncf-demo.$INGRESS_HOST\"" \
    ytt/values-prod.yaml

yq --inplace ".ingress.className = \"$INGRESS_CLASSNAME\"" \
    ytt/values-prod.yaml

yq --inplace ".fga.enabled = true" ytt/values-prod.yaml

yq --inplace ".fga.storeId = \"$FGA_STORE_ID\"" \
    ytt/values-prod.yaml

yq --inplace ".fga.modeId = \"$FGA_MODEL_ID\"" \
    ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "Switched to ESO"

git push

kubectl --namespace production get pods

# Wait until new Pods are created

curl "http://cncf-demo.$INGRESS_HOST/videos"

curl "http://cncf-demo.$INGRESS_HOST/videos?user=jdoe"

curl "http://cncf-demo.$INGRESS_HOST/videos?user=sfarcic"

curl -X POST "http://cncf-demo.$INGRESS_HOST/video?id=-qeoLfSGlFU&title=DevOps%20Tools%202024&user=sfarcic"

curl -X POST "http://cncf-demo.$INGRESS_HOST/video?id=-qeoLfSGlFU&title=DevOps%20Tools%202024&user=vfarcic"

curl "http://cncf-demo.$INGRESS_HOST/videos" | jq .
```

## Continue The Adventure

* [Security Misfits](../security-misc/README.md)
