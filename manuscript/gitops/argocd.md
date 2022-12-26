# GitOps With Argo CD

TODO: Intro

## Setup

```bash
helm repo add argo https://argoproj.github.io/argo-helm

helm repo update
```

## Do

```bash
./crossplane/get-kubeconfig-$XP_DESTINATION.sh

cat argocd/helm-values.yaml

helm upgrade --install argocd argo/argo-cd \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

cat argocd/project.yaml

kubectl apply --filename argocd/project.yaml

cat argocd/apps.yaml

kubectl apply --filename argocd/apps.yaml

kubectl --namespace argocd get ingresses

cat argocd/cert-manager.yaml

cp argocd/cert-manager.yaml infra/.


helm upgrade --install cert-manager jetstack/cert-manager \
    --namespace cert-manager --create-namespace \
    --set installCRDs=true --wait

# Replace `[...]` with your email
export EMAIL=[...]

# Install `yq` CLI from https://github.com/mikefarah/yq
# Install `jq` CLI from https://stedolan.github.io/jq/download

yq --inplace ".spec.acme.email = \"$EMAIL\"" \
    cert-manager/issuer.yaml

kubectl apply --filename cert-manager/issuer.yaml

kubectl krew install schemahero

kubectl schemahero install
```

## Continue The Adventure

[Ingress](../ingress/story.md)
