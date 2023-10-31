# Deploy The App Defined As cdk8s To Production With GitOps

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/app/cdk8s.sh

./manuscript/app/cdk8s.sh

source .env
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
