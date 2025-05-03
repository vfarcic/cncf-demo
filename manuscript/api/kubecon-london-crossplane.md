# API (CRDs) & State Management (Controllers) With Crossplane

TODO: Intro

## Setup

```sh
export API=crossplane

echo "export API=crossplane" | tee -a .env
```

## Do

```sh
crossplane beta trace --namespace production githubclaim cncf-demo-app

cd cncf-demo-app

cat main.go

cp ../crossplane/$HYPERSCALER-sql.yaml apps/silly-demo-db.yaml

cp ../crossplane/$HYPERSCALER-sql-password.yaml \
    apps/silly-demo-db-password.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo-db-password.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo-db.yaml

cat apps/silly-demo-db.yaml

crossplane beta trace --namespace production \
    sqlclaim silly-demo-db

cp ../crossplane/app.yaml apps/silly-demo.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo.yaml

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
* [Open Policy Agent (OPA) With Gatekeeper](../policies-idp/kubecon-london-gatekeeper.md)
* [Kubernetes Validating Admission Policy](../policies-idp/kubecon-london-vap.md)
