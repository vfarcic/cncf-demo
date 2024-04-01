# Access Authorization With OpenFGA and Kustomize

TODO: Intro

## Do

```bash
yq --inplace ".[0].value = \"cncf-demo.$INGRESS_HOST\"" \
    kustomize/overlays/prod/ingress.yaml

yq --inplace ".[1].value = \"cncf-demo.$INGRESS_HOST\"" \
    kustomize/overlays/prod/ingress.yaml

yq --inplace ".[2].value = \"$INGRESS_CLASSNAME\"" \
    kustomize/overlays/prod/ingress.yaml

yq --inplace ".spec.template.spec.containers[0].env[5].value = \"http://openfga.openfga:8080\"" \
    kustomize/overlays/prod/deployment-crossplane-postgresql-$HYPERSCALER.yaml

yq --inplace ".spec.template.spec.containers[0].env[6].value = \"$FGA_STORE_ID\"" \
    kustomize/overlays/prod/deployment-crossplane-postgresql-$HYPERSCALER.yaml

yq --inplace ".spec.template.spec.containers[0].env[7].value = \"$FGA_MODEL_ID\"" \
    kustomize/overlays/prod/deployment-crossplane-postgresql-$HYPERSCALER.yaml

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
