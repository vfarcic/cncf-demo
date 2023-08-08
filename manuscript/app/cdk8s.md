# Deploy The App Defined As cdk8s To Production With GitOps

TODO: Intro

## Setup

```bash
export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

export DOMAIN=$(yq ".production.domain" settings.yaml)

export INGRESS_CLASS_NAME=$(\
    yq ".production.ingress.className" settings.yaml)

# Execute the command that follows only if you are using Argo CD
export REPO_URL=$(git config --get remote.origin.url)

# Execute the command that follows only if you are using Argo CD
yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    $GITOPS_APP/cncf-demo-cdk8s.yaml

export TAG=$(yq ".tag" settings.yaml)

export INGRESS_IP=$(yq ".production.ingress.ip" settings.yaml)

echo $INGRESS_IP

# Configure DNS for the following subdomains (skip this step if
#   you chose to use `nip.io` instead of a "real" domain):
# - cncf-demo
```

## Do

```bash
cat $GITOPS_APP/cncf-demo-cdk8s.yaml

cp $GITOPS_APP/cncf-demo-cdk8s.yaml apps/cncf-demo.yaml

cd cdk8s

export ENVIRONMENT=prod

yq --inplace ".image.tag = \"$TAG\"" app-prod.yaml

yq --inplace ".ingress.host = \"cncf-demo.$DOMAIN\"" \
    app-prod.yaml

yq --inplace ".ingress.className = \"$INGRESS_CLASS_NAME\"" \
    app-prod.yaml

cdk8s synth --output ../yaml/prod --validate 

cd ..

cat yaml/prod/cncf-demo.k8s.yaml

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

* [Setup PostgreSQL DB In The Production Environment](../db-production/README.md)
