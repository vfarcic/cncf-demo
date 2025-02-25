# API (CRDs) & State Management (Controllers) With KubeVela

TODO: Intro

## Do

```sh
cd cncf-demo-app

cp ../kubevela/$HYPERSCALER-sql.yaml apps/silly-demo-db.yaml

cp ../kubevela/$HYPERSCALER-sql-password.yaml \
    apps/silly-demo-db-password.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo-db-password.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo-db.yaml

cat apps/silly-demo-db-password.yaml

cat apps/silly-demo-db.yaml

kubectl get managed

cp ../kubevela/app.yaml apps/silly-demo.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo.yaml

cat apps/silly-demo.yaml

kubectl --namespace production get all,ingresses
```

> The Pod `STATUS` is `ErrImagePull` because there is no image. We'll fix that later.

```sh
vela delete silly-demo --yes

cat ../kubevela/component-app-backend.cue

cat ../kubevela/component-db-$HYPERSCALER.cue

git add .

git commit -m "Apps"

git pull

git push

cd ..
```

## What Is Your Choice?

* [Kyverno](../policies-idp/kubecon-london-kyverno.md)
* [Open Policy Agent (OPA) With Gatekeeper](../policies-idp/kubecon-london-gatekeeper.md)
* [Kubernetes Validating Admission Policy](../policies-idp/kubecon-london-vap.md)
