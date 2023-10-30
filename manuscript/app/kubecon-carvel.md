# Deploy The App Defined As Carvel ytt To Production With GitOps

TODO: Intro

## Setup

```bash
./manuscript/app/carvel.sh

source .env
```

## Do

```bash
cat $GITOPS_APP/cncf-demo-ytt.yaml

cp $GITOPS_APP/cncf-demo-ytt.yaml apps/cncf-demo.yaml

yq --inplace ".image.tag = \"$TAG\"" ytt/values-prod.yaml

yq --inplace ".ingress.host = \"cncf-demo.$DOMAIN\"" \
    ytt/values-prod.yaml

yq --inplace ".ingress.className = \"$INGRESS_CLASS_NAME\"" \
    ytt/values-prod.yaml

cat ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "cncf-demo v0.0.1"

git push

kubectl --namespace production get all,ingresses

echo "http://cncf-demo.$DOMAIN"

# Open it in a browser.
```

## Continue The Adventure

* [Setup PostgreSQL DB In The Production Environment](../db-production/README.md)
