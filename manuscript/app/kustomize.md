# Deploy The App Defined As Kustomize To Production With GitOps

TODO: Intro

## Setup

```bash
export REPO_URL=$(git config --get remote.origin.url)

export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

# Execute the command that follows only if you are using Argo CD
yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    $GITOPS_APP/cncf-demo-kustomize.yaml

export IMAGE=$(yq ".image" settings.yaml)

export TAG=$(yq ".tag" settings.yaml)

yq --inplace \
    ".spec.template.spec.containers[0].image = \"$IMAGE\"" \
    kustomize/base/deployment.yaml

export INGRESS_IP=$(yq ".production.ingress.ip" settings.yaml)

echo $INGRESS_IP

# Configure DNS for the following subdomains (skip this step if
#   you chose to use `nip.io` instead of a "real" domain):
# - cncf-demo
```

## Do

```bash
cat $GITOPS_APP/cncf-demo-kustomize.yaml

cp $GITOPS_APP/cncf-demo-kustomize.yaml apps/cncf-demo.yaml

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
