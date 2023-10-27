# GitOps With Carvel kapp-controller

An *App* is a Custom Resource Definition in Carvel kapp-controller that groups Kubernetes resources as defined by a manifest. Below we create Carvel kapp-controller Apps for our infrastructure-specific resources⎯SchemaHero and cert-manager, and then we create a third Carvel kapp-controller App that groups SchemaHero and cert-manager with each other.

We also create an Carvel kapp-controller App that will eventually watch our Hero application-related resources, but for now it will point at an empty directory called 'apps'. Later when we are ready to deploy our Hero application and backing services into the production cluster we will make Carvel kapp-controller App resources for each of them and place them into this 'apps' directory.

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/gitops/kapp.sh

./manuscript/gitops/kapp.sh

source .env
```

## Do

```bash
# Install kapp-controller

kubectl apply \
    --filename https://github.com/vmware-tanzu/carvel-kapp-controller/releases/latest/download/release.yml

# Create ServiceAccount, ClusterRole, and ClusterRoleBinding so that kapp-controller can access and change management cluster
# Create namespaces

kubectl apply --filename kapp-controller/preperation.yaml

# Create a SchemaHero App definition and store it in the infra folder

ls -1 schema-hero

cat kapp-controller/schema-hero.yaml

cp kapp-controller/schema-hero.yaml infra/.

# Create a cert-manager App definition and store it in the infra folder

cat kapp-controller/cert-manager.yaml

cp kapp-controller/cert-manager.yaml infra/.

# Commit to Git

git add .

git commit -m "Infra"

git push

# Create an App definition called 'production-apps' and point it at the 'apps' directory that is currently empty
# Create an App definition that groups the SchemaHero and cert-manager Apps into an Carvel kapp-controller App called 'production-infra'

cat kapp-controller/apps.yaml

# Apply the 'production-apps' and 'production-infra' Apps to the cluster. The 'production-infra' App will additionally deploy the Carvel kapp-controller Apps that watch SchemaHero and cert-manager. However the 'production-apps' App won't deploy any resources becuase the 'apps' directory is empty.

kubectl apply --filename kapp-controller/apps.yaml

kubectl --namespace carvel-apps get apps

kubectl --namespace schemahero-system get all

# Wait until the SchemaHero resources appear in the Namespace

kubectl --namespace cert-manager get all

# Wait until the cert-manager resources appear in the Namespace

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

yq --inplace ".gitOps.app = \"kapp-controller\"" settings.yaml
```

## Continue The Adventure

* [Ingress](../ingress/README.md)
