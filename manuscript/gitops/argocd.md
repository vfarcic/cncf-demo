# GitOps With Argo CD

TODO: Intro

## Setup

```bash
helm repo add argo https://argoproj.github.io/argo-helm

helm repo update

export REPO_URL=$(git config --get remote.origin.url)

yq --inplace \
    ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/apps.yaml
```

## Do

```bash
cat argocd/helm-values.yaml

helm upgrade --install argocd argo/argo-cd \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

cat argocd/project.yaml

kubectl apply --filename argocd/project.yaml

cat argocd/apps.yaml

kubectl apply --filename argocd/apps.yaml

ls -1 schema-hero

cat argocd/schema-hero.yaml

cp argocd/schema-hero.yaml infra/.

cat argocd/cert-manager.yaml

cp argocd/cert-manager.yaml infra/.

git add .

git commit -m "Infra"

git push

kubectl --namespace schemahero-system get all

# Wait until the resources appear in the Namespace

kubectl --namespace cert-manager get all

# Wait until the resources appear in the Namespace

# Replace `[...]` with your email
export EMAIL=[...]

# Install `yq` CLI from https://github.com/mikefarah/yq

cat cert-manager/issuer.yaml

cp cert-manager/issuer.yaml infra/.

yq --inplace ".spec.acme.email = \"$EMAIL\"" infra/issuer.yaml

yq --inplace \
    ".spec.acme.solvers[0].http01.ingress.class = \"$INGRESS_CLASS_NAME\"" \
    infra/issuer.yaml

git add .

git commit -m "Infra"

git push
```

## Continue The Adventure

[Ingress](../ingress/story.md)
