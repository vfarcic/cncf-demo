# GitOps With Flux

## Setup

```bash
./manuscript/gitops/flux.sh

source .env
```

## Do

```bash
flux bootstrap github --owner $GITHUB_ORG \
    --repository cncf-demo --branch main --path ./infra \
    --personal

git pull

kubectl --namespace flux-system get gitrepositories

# Wait until the three repository is ready

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

kubectl --namespace cert-manager get all

export GITOPS_APP=flux
```

## What Is Your Choice?

* [ingress-nginx](../ingress/rejekts-paris-nginx.md)
* [Envoy with Contour](../ingress/rejekts-paris-contour.md)
* [Emissary-ingress](../ingress/rejekts-paris-emissary-ingress.md)
