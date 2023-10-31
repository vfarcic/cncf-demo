# GitOps With Argo CD

## Setup

```bash
./manuscript/gitops/argocd.sh
```

## Do

```bash
cat argocd/helm-values.yaml

helm upgrade --install argocd argo-cd \
    --repo https://argoproj.github.io/argo-helm \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

cat argocd/project.yaml

kubectl apply --filename argocd/project.yaml

ls -1 schema-hero

cat argocd/schema-hero.yaml

cp argocd/schema-hero.yaml infra/.

cat argocd/cert-manager.yaml

cp argocd/cert-manager.yaml infra/.

git add .

git commit -m "Infra"

git push

cat argocd/apps.yaml

kubectl apply --filename argocd/apps.yaml

kubectl --namespace argocd get applications

kubectl --namespace schemahero-system get all

# Wait until the SchemaHero resources appear in the Namespace

kubectl --namespace cert-manager get all

# Wait until the cert-manager resources appear in the Namespace

export GITOPS_APP=argocd
```

## Continue The Adventure

* [ingress-nginx](../ingress/kubecon-nginx.md)
* [Envoy with Contour](../ingress/kubecon-contour.md)
* [Emissary-ingress](../ingress/kubecon-emissary-ingress.md)
