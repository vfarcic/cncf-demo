# API (CRDs) & State Management (Controllers) With KubeVela

## Setup

```sh
./manuscript/api/kubevela.sh
```

## Do

```sh
cat apps/silly-demo-db.yaml && kubectl get managed

cat apps/silly-demo.yaml

kubectl --namespace production get all,ingresses
```

> The Pod `STATUS` is `ErrImagePull` because there is no image. We'll fix that later.

```sh
cat ../kubevela/component-app-backend.cue

cat ../kubevela/component-db-$HYPERSCALER.cue

vela delete silly-demo --yes

git add .

git commit -m "Apps"

git pull

git push

cd ..
```

## What Is Your Choice?

* [Kyverno](../policies-idp/kubecon-london-kyverno.md)
* [Kubernetes Validating Admission Policy](../policies-idp/kubecon-london-vap.md)
