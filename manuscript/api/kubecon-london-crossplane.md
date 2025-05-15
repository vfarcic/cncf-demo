# API (CRDs) & State Management (Controllers) With Crossplane

TODO: Intro

## Setup

```sh
./manuscript/api/crossplane.sh

source .env
```

## Do

```sh
crossplane beta trace --namespace production githubclaim cncf-demo-app

cd cncf-demo-app

cat main.go

cat apps/silly-demo-db.yaml

crossplane beta trace --namespace production \
    sqlclaim silly-demo-db

cat apps/silly-demo.yaml

kubectl --namespace production get all,ingresses
```

> The Pod `STATUS` is `ErrImagePull` because there is no image. We'll fix that later.

```sh
kubectl --namespace production delete \
    --filename apps/silly-demo.yaml

git add .

git commit -m "Apps"

git push

cd ..
```

## Continue The Adventure

* [Kyverno](../policies-idp/kubecon-london-kyverno.md)
* [Kubernetes Validating Admission Policy](../policies-idp/kubecon-london-vap.md)
