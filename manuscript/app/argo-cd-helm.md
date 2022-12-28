# Deploy The App Defined As Helm Chart To Production With Argo CD

TODO: Intro

## Setup

```bash
yq --inplace \
    ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/cncf-demo-helm.yaml

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
cat argocd/cncf-demo-helm.yaml

cp argocd/cncf-demo-helm.yaml apps/cncf-demo.yaml

export VALUES=$(\
    yq ".spec.source.helm.values" apps/cncf-demo.yaml \
    | yq ".image.tag = \"$TAG\"" \
    | yq ".ingress.host = \"cncf-demo.$DOMAIN\"" \
    | yq ".ingress.className = \"$INGRESS_CLASS_NAME\"")

echo $VALUES

yq --inplace ".spec.source.helm.values = \"$VALUES\"" \
    apps/cncf-demo.yaml

cat apps/cncf-demo.yaml

git add .

git commit -m "cncf-demo v0.0.1"

git push

kubectl --namespace production get all,ingresses

echo "https://cncf-demo.$DOMAIN"

# Open it in a browser.
```

## Continue The Adventure

[TODO:](TODO:)
