# GitOps With Argo CD

## Do

```bash
# It's already installed

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

kubectl --namespace cert-manager get all

export GITOPS_APP=argocd
```

## What Is Your Choice?

* [ingress-nginx](../ingress/rejekts-paris-nginx.md)
* [Envoy with Contour](../ingress/rejekts-paris-contour.md)
* [Emissary-ingress](../ingress/rejekts-paris-emissary-ingress.md)
