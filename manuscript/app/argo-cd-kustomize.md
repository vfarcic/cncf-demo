# Deploy The App Defined As Kustomize To Production With Argo CD

TODO: Intro

## Setup

```bash
yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/cncf-demo-kustomize.yaml

# Execute the command that follows only if you jumped directly
#    into this chapter (if you did not go through the steps that
#    built and pushed the image to a registry).
export IMAGE=index.docker.io/vfarcic/cncf-demo

# Execute the command that follows only if you jumped directly
#    into this chapter (if you did not go through the steps that
#    built and pushed the image to a registry).
export TAG=v0.0.1

echo $INGRESS_HOST

# Configure DNS for the following subdomains (skip this step if
#   you chose to use `nip.io` instead of a "real" domain):
# - cncf-demo
```

## Do

```bash
cat argocd/cncf-demo-kustomize.yaml

cp argocd/cncf-demo-kustomize.yaml apps/cncf-demo.yaml

cd kustomize/overlays/prod

kustomize edit set image $IMAGE=$IMAGE:$TAG

cat kustomization.yaml

cd ../../../

yq --inplace ".[0].value = \"cncf-demo.$DOMAIN\"" \
    kustomize/overlays/prod/ingress.yaml

yq --inplace ".[1].value = \"cncf-demo.$DOMAIN\"" \
    kustomize/overlays/prod/ingress.yaml

yq --inplace ".[2].value = \"$INGRESS_CLASS_NAME\"" \
    kustomize/overlays/prod/ingress.yaml

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
