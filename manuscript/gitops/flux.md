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

./crossplane/get-kubeconfig-$XP_DESTINATION.sh
```

## Do

```bash
flux bootstrap github --owner $GITHUB_ORG \
    --repository cncf-demo --branch main --path ./flux-system \
    --personal

git pull

flux create source git infra --url $REPO_URL --branch main \
    --interval 30s --export | tee ./flux/infra.yaml

flux create source git apps --url $REPO_URL --branch main \
    --interval 30s --export | tee ./flux/apps.yaml

git add .

git commit -m "Flux"

git push

ls -1 schema-hero

cat flux/schema-hero.yaml

cp flux/schema-hero.yaml infra/.

# TODO: Continue




cat argocd/cert-manager.yaml

cp argocd/cert-manager.yaml infra/.

git add .

git commit -m "Infra"

git push

cat argocd/apps.yaml

kubectl apply --filename argocd/apps.yaml

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
```

## Continue The Adventure

[Ingress](../ingress/story.md)
