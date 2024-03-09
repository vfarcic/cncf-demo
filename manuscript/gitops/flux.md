# GitOps With Flux

The process of installing Flux in a GitOps manner is called a *bootstrap*. The manifests that install Flux are applied to the cluster, a *GitRepository* Custom Resource and *Kustomization* Custom Resource are created for the Flux components, then the manifests are pushed to an existing Git repository (or a new one is created). Flux can manage itself just as it manages other resources.

An *Kustomization* is a Custom Resource Definition in Flux that groups Kubernetes resources that Flux is supposed to reconcile in the cluster. Below we create Flux Kustomizations for our infrastructure-specific resources⎯SchemaHero and cert-manager, and then we place those Kustomizations together the 'infra' folder that itself is a Flux Kustomization (one we set up as part of the bootstrap process). 

We also create an Flux Kustomization that will eventually watch our Hero application-related resources, but for now it will point at an empty directory called 'apps'. Later when we are ready to deploy our Hero application and backing services into the production cluster we will make Flux Kustomization resources for each of them and place them into this 'apps' directory.

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/gitops/flux.sh

./manuscript/gitops/flux.sh

source .env
```

## Do

```bash
# Install Flux
# Here the Flux 'bootstrap' command finds the git repository 'cncf-demo' on your GitHub account, adds Flux component definitions to the repository, deploys Flux components to your Kubernetes Cluster, and configures Flux components to track the path './infra' in the repository.


flux bootstrap github --owner $GITHUB_ORG \
    --repository cncf-demo --branch main --path ./infra \
    --personal

git pull

kubectl --namespace flux-system get gitrepositories

# Wait until the three repository is ready

# Create a SchemaHero Kustomization definition and store it in the infra folder so that it is tracked by Flux

ls -1 schema-hero

cat flux/schema-hero.yaml

cp flux/schema-hero.yaml infra/.

# Create a cert-manager Kustomization definition and store it in the infra folder so that it is tracked by Flux

cat flux/cert-manager.yaml

cp flux/cert-manager.yaml infra/.

# Create an Kustomization definition for our application and call it 'production-apps' and point it at the 'apps' directory that is currently empty. Now Flux components are configured to additionally track the path ./apps in the repository 
# Store this definition in the infra folder so that it is tracked by Flux

cat flux/apps.yaml

cp flux/apps.yaml infra/apps.yaml

# Commit to Git

git add .

git commit -m "Infra"

git push

kubectl --namespace flux-system \
    get gitrepositories,kustomizations,helmrepositories,helmreleases

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

git add .

git commit -m "Infra"

git push

yq --inplace ".gitOps.app = \"flux\"" settings.yaml
```

## Continue The Adventure

* [Ingress](../ingress/README.md)
