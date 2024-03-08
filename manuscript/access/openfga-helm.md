# Access Authorization With OpenFGA and Helm

TODO: Intro

## Do

```bash
# Execute only if using Argo CD
yq --inplace ".spec.source.helm.parameters[1] = \"cncf-demo.$INGRESS_HOST\"" \
    argocd/cncf-demo-helm.yaml

# Execute only if using Argo CD
yq --inplace ".spec.source.helm.parameters[2] = \"$INGRESS_CLASSNAME\"" \
    argocd/cncf-demo-helm.yaml

# Execute only if using Argo CD
yq --inplace ".spec.source.helm.parameters[12] = \"true\"" \
    argocd/cncf-demo-helm.yaml

# Execute only if using Argo CD
yq --inplace ".spec.source.helm.parameters[13] = \"$FGA_STORE_ID\"" \
    argocd/cncf-demo-helm.yaml

# Execute only if using Argo CD
yq --inplace ".spec.source.helm.parameters[14] = \"$FGA_MODEL_ID\"" \
    argocd/cncf-demo-helm.yaml

# Execute only if using Flux
yq --inplace ".spec.values.ingress.host = \"cncf-demo.$INGRESS_HOST\"" \
    argocd/cncf-demo-helm.yaml

# Execute only if using Flux
yq --inplace ".spec.values.ingress.className = \"$INGRESS_CLASSNAME\"" \
    argocd/cncf-demo-helm.yaml

# Execute only if using Flux
yq --inplace ".spec.values.fga.enabled = true" \
    argocd/cncf-demo-helm.yaml

# Execute only if using Flux
yq --inplace ".spec.values.fga.storeId = \"$FGA_STORE_ID\"" \
    argocd/cncf-demo-helm.yaml

# Execute only if using Flux
yq --inplace ".spec.values.fga.modeId = \"$FGA_MODEL_ID\"" \
    argocd/cncf-demo-helm.yaml

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

* [Secrets Management Outside Kubernetes](client.md)
