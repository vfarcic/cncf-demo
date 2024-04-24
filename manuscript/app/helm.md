# Deploy The App Defined As Helm Chart To Production With GitOps

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/app/helm.sh

./manuscript/app/helm.sh

source .env
```

## Do

```bash
cat $GITOPS_APP/cncf-demo-helm.yaml

cp $GITOPS_APP/cncf-demo-helm.yaml apps/cncf-demo.yaml

# Execute the command that follows only if you are using Argo CD
yq --inplace ".spec.source.helm.valuesObject.image.tag = \"$TAG\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Argo CD
yq --inplace ".spec.source.helm.valuesObject.ingress.host = \"cncf-demo.$DOMAIN\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Argo CD
yq --inplace ".spec.source.helm.valuesObject.ingress.className = \"$INGRESS_CLASS_NAME\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Flux
yq --inplace ".spec.values.image.tag = \"$TAG\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Flux
yq --inplace \
    ".spec.values.ingress.host = \"cncf-demo.$DOMAIN\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Flux
yq --inplace \
    ".spec.values.ingress.className = \"$INGRESS_CLASS_NAME\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Carvel
#   kapp-controller.
echo "
---
apiVersion: v1
kind: Secret
metadata:
  name: cncf-demo-values
  namespace: carvel-apps
stringData:
  cncf-demo-values.yaml: |
    image:
      tag: $TAG
    ingress:
      host: cncf-demo.$DOMAIN
      className: $INGRESS_CLASS_NAME
    tls:
      enabled: true
spec:
  source:
    repoURL: https://github.com/devopsparadox/cncf-demo.git" \
    | tee -a apps/cncf-demo.yaml

cat apps/cncf-demo.yaml

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
