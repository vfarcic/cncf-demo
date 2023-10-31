# GitOps With Argo CD

After we install Argo CD into our management cluster, we first make an Argo CD *Project*. A Project is a collection of Argo CD *Applications*. A Project provides isolation between different teams and is a place where access control can be implemented. 

An *Application* is a Custom Resource Definition in Argo CD that groups Kubernetes resources as defined by a manifest. Below we create Argo CD Applications for our infrastructure-specific resources⎯SchemaHero and cert-manager, and then we create a third Argo CD Application that groups SchemaHero and cert-manager with each other.

We also create an Argo CD Application that will eventually watch our Hero application-related resources, but for now it will point at an empty directory called 'apps'. Later when we are ready to deploy our Hero application and backing services into the production cluster we will make Argo CD Application resources for each of them and place them into this 'apps' directory.

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/gitops/argocd.sh

./manuscript/gitops/argocd.sh

source .env
```

## Do

```bash
# Install Argo CD and provide it with credentials to make changes to our cluster

cat argocd/helm-values.yaml

helm upgrade --install argocd argo-cd \
    --repo https://argoproj.github.io/argo-helm \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

# Create an Argo CD 'Project'

cat argocd/project.yaml

kubectl apply --filename argocd/project.yaml

# Create a SchemaHero Application definition and store it in the infra folder

ls -1 schema-hero

cat argocd/schema-hero.yaml

cp argocd/schema-hero.yaml infra/.

# Create a cert-manager Application definition and store it in the infra folder

cat argocd/cert-manager.yaml

cp argocd/cert-manager.yaml infra/.

# Commit to Git

git add .

git commit -m "Infra"

git push

# Create an Application definition for our application and call it 'production-apps' and point it at the 'apps' directory that is currently empty
# Create an Application definition that groups the SchemaHero and cert-manager Applications into an Argo CD Application called 'production-infra'

cat argocd/apps.yaml

# Apply the 'production-apps' and 'production-infra' Applications to the cluster. The 'production-infra' Application will additionally deploy the Argo CD Applications that watch SchemaHero and cert-manager. However the 'production-apps' Application won't deploy any resources becuase the 'apps' directory is empty.

kubectl apply --filename argocd/apps.yaml

kubectl --namespace argocd get applications

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

# Commit to Git    

git add .

git commit -m "Infra"

git push

yq --inplace ".gitOps.app = \"argocd\"" settings.yaml
```

## Continue The Adventure

* [Ingress](../ingress/README.md)
