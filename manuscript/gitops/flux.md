# GitOps With Flux

TODO: Intro

## Setup

* Install [`flux` CLI](https://fluxcd.io/flux/get-started/#install-the-flux-cli)

```bash
export REPO_URL=$(git config --get remote.origin.url)

# Replace `[...]` with your GitHub token
export GITHUB_TOKEN=[...]

# Replace `[...]` with your GitHub user
export GITHUB_USER=[...]

# Replace `[...]` with the GitHub organization where the repo is located
export GITHUB_ORG=[...]
```

## Do

```bash
flux bootstrap github --owner $GITHUB_ORG \
    --repository cncf-demo --branch main --path ./infra \
    --personal

git pull

kubectl --namespace flux-system get gitrepositories

# Wait until all three repositories are ready

ls -1 schema-hero

cat flux/schema-hero.yaml

cp flux/schema-hero.yaml infra/.

cat flux/cert-manager.yaml

cp flux/cert-manager.yaml infra/.

cat flux/apps.yaml

cp flux/apps.yaml infra/apps.yaml

git add .

git commit -m "Infra"

git push

kubectl --namespace flux-system \
    get gitrepositories,kustomizations,helmrepositories,helmreleases

kubectl --namespace schemahero-system get all

# Wait until the resources appear in the Namespace

kubectl --namespace cert-manager get all

# Wait until the resources appear in the Namespace

# Replace `[...]` with your email
# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
export EMAIL=[...]

# Install `yq` CLI from https://github.com/mikefarah/yq

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

export GITOPS_APP=flux
```

## Continue The Adventure

[Ingress](../ingress/story.md)
