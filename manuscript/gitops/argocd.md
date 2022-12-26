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

# TODO: Install if the cluster was not created with Crossplane
kubectl --namespace schemahero-system get all

cat argocd/cert-manager.yaml

cp argocd/cert-manager.yaml infra/.

git add .

git commit -m "Infra"

git push

kubectl --namespace cert-manager get all
```

## Continue The Adventure

[Ingress](../ingress/story.md)
