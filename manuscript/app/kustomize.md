# Deploy The App Defined As Kustomize To Production With GitOps

TODO: Intro

* If you chose to do GitOps with Carvel kapp-controller, **Kustomize is not yet supported** and you should choose a different way to define the app. Please go back to [Deploy the App to Production](README.md) and pick a different format.

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/app/kustomize.sh

./manuscript/app/kustomize.sh

source .env
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

* [Setup PostgreSQL DB In The Production Environment](../db-production/README.md)
