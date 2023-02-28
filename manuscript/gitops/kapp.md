# GitOps With Carvel kapp-controller

TODO: Intro

## Setup

```bash
export REPO_URL=$(git config --get remote.origin.url)

yq --inplace ".spec.fetch[0].git.url = \"$REPO_URL\"" \
    kapp-controller/apps.yaml
```

## Do

```bash

kubectl apply -f https://github.com/vmware-tanzu/carvel-kapp-controller/releases/latest/download/release.yml

# Install kapp controller CLI
wget -O- https://carvel.dev/install.sh > install.sh
sudo bash install.sh

ls -1 schema-hero

cat kapp-controller/schema-hero.yaml

cp kapp-controller/schema-hero.yaml infra/.

cat kapp-controller/cert-manager.yaml

cp kapp-controller/cert-manager.yaml infra/.

git add .

git commit -m "Infra"

git push

cat kapp-controller/apps.yaml

kubectl apply --filename kapp-controller/apps.yaml

kubectl --namespace carvel-apps get apps

kubectl --namespace schemahero-system get all

# Wait until the resources appear in the Namespace

kubectl --namespace cert-manager get all

# Wait until the resources appear in the Namespace

# Replace `[...]` with your email
# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
export EMAIL=[...]

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
cat cert-manager/issuer.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
cp cert-manager/issuer.yaml infra/.

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
yq --inplace ".spec.acme.email = \"$EMAIL\"" infra/issuer.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
yq --inplace \
    ".spec.acme.solvers[0].http01.ingress.class = \"$INGRESS_CLASS_NAME\"" \
    infra/issuer.yaml

git add .

git commit -m "Infra"

git push

yq --inplace ".gitOps.app = \"kapp-controller\"" settings.yaml
```

## Continue The Adventure

[Ingress](../ingress/README.md)
