# Deploy The App Defined As Carvel ytt To Production With Argo CD

TODO: Intro

## Setup

```bash
yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/cncf-demo-ytt.yaml

# Execute command that follows only if you jumped directly into
#   this chapter (if you did not go through the steps that built
#   and pushed the image to a registry).
export TAG=v0.0.1

echo $INGRESS_HOST

# Configure DNS for the following subdomains (skip this step if
#   you chose to use `nip.io` instead of a "real" domain):
# - cncf-demo
```

## Do

```bash
cat argocd/cncf-demo-ytt.yaml

cp argocd/cncf-demo-ytt.yaml apps/cncf-demo.yaml

yq --inplace ".image.tag = \"$TAG\"" ytt/values-prod.yaml

yq --inplace ".ingress.host = \"cncf-demo.$DOMAIN\"" \
    ytt/values-prod.yaml

yq --inplace ".ingress.className = \"$INGRESS_CLASS_NAME\"" \
    ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "cncf-demo v0.0.1"

git push

kubectl --namespace production get all,ingresses

# If you chose to use `nip.io` instead of a "real" domain,
#   replace `https` with `http`.
echo "https://cncf-demo.$DOMAIN"

# Open it in a browser.
```

## Continue The Adventure

[Setup PostgreSQL DB In The Production Environment](../db-production/story.md)
