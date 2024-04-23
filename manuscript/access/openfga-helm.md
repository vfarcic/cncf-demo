# Access Authorization With OpenFGA and Helm

TODO: Intro

## Do

```bash
# Execute only if using Argo CD
export VALUES_PATH=.spec.source.helm.valuesObject

# Execute only if using Flux
export VALUES_PATH=.spec.values

yq --inplace \
    "$VALUES_PATH.ingress.host = \"cncf-demo.$INGRESS_HOST\"" \
    $GITOPS_APP/cncf-demo-helm.yaml

yq --inplace \
    "$VALUES_PATH.ingress.className = \"$INGRESS_CLASSNAME\"" \
    $GITOPS_APP/cncf-demo-helm.yaml

yq --inplace "$VALUES_PATH.fga.enabled = true" \
    $GITOPS_APP/cncf-demo-helm.yaml

yq --inplace "$VALUES_PATH.fga.storeId = \"$FGA_STORE_ID\"" \
    $GITOPS_APP/cncf-demo-helm.yaml

yq --inplace "$VALUES_PATH.fga.modeId = \"$FGA_MODEL_ID\"" \
    $GITOPS_APP/cncf-demo-helm.yaml

cp $GITOPS_APP/cncf-demo-helm.yaml apps/cncf-demo.yaml

cat apps/cncf-demo.yaml

git add .

git commit -m "Switched to ESO"

git push

kubectl --namespace production get pods

# Wait until new Pod is created

curl "http://cncf-demo.$INGRESS_HOST/videos"

curl "http://cncf-demo.$INGRESS_HOST/videos?user=jdoe"

curl "http://cncf-demo.$INGRESS_HOST/videos?user=sfarcic"

curl -X POST "http://cncf-demo.$INGRESS_HOST/video?id=-qeoLfSGlFU&title=DevOps%20Tools%202024&user=sfarcic"

curl -X POST "http://cncf-demo.$INGRESS_HOST/video?id=-qeoLfSGlFU&title=DevOps%20Tools%202024&user=vfarcic"

curl "http://cncf-demo.$INGRESS_HOST/videos" | jq .
```

## Continue The Adventure

* [Security Misfits](../security-misc/README.md)
