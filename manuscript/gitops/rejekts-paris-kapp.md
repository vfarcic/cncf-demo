# GitOps With Carvel kapp-controller

## Do

```bash
kubectl apply \
    --filename https://github.com/vmware-tanzu/carvel-kapp-controller/releases/latest/download/release.yml

kubectl apply --filename kapp-controller/preperation.yaml

ls -1 schema-hero

cat kapp-controller/schema-hero.yaml

cp kapp-controller/schema-hero.yaml infra/.

cat kapp-controller/cert-manager.yaml

cp kapp-controller/cert-manager.yaml infra/.

git add .

git commit -m "Infra"

git push

cat kapp-controller/apps.yaml

kubectl apply --filename kapp-controller/apps.yaml

kubectl --namespace carvel-apps get apps

kubectl --namespace schemahero-system get all

# Wait until the SchemaHero resources appear in the Namespace

kubectl --namespace cert-manager get all

# Wait until the cert-manager resources appear in the Namespace

export GITOPS_APP=kapp-controller
```

## What Is Your Choice?

* [ingress-nginx](../ingress/rejekts-paris-nginx.md)
* [Envoy with Contour](../ingress/rejekts-paris-contour.md)
* [Emissary-ingress](../ingress/rejekts-paris-emissary-ingress.md)