# GitOps With Flux

## Do

```bash
flux bootstrap github --owner $GITHUB_ORG \
    --repository cncf-demo --branch main --path ./infra \
    --personal

git pull

kubectl --namespace flux-system get gitrepositories

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

kubectl --namespace flux-system get gitrepositories,kustomizations,helmrepositories,helmreleases

kubectl --namespace schemahero-system get all

kubectl --namespace cert-manager get all

export GITOPS_APP=flux
```

## Continue The Adventure

* [ingress-nginx](../ingress/kubecon-nginx.md)
* [Envoy with Contour](../ingress/kubecon-contour.md)
* [Emissary-ingress](../ingress/kubecon-emissary-ingress.md)
