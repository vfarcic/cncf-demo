# Policies With Kustomize

TODO: Intro

## Setup

```bash
rm -f apps/cncf-demo.yaml

git add .

git commit -m "Starting over with policies by removing the app"

git push

kubectl --namespace production get all,ingresses

# Wait until the Namespace is empty

export PROVIDER=$(yq ".crossplane.destination" settings.yaml)
```

## Do

```bash
cp $GITOPS_APP/cncf-demo-kustomize.yaml apps/cncf-demo.yaml

git add .

git commit -m "CNCF Demo"

git push

kubectl --namespace production get all

kubectl describe $POLICY_KIND deployment-production

cat kustomize/overlays/prod/deployment-scaled.yaml

yq --inplace \
    ".patchesStrategicMerge += \"deployment-scaled.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

git add .

git commit -m "CNCF Demo scaled"

git push

kubectl --namespace production get all

kubectl --namespace production get sqlclaims

kubectl describe $POLICY_KIND db-cluster

kubectl describe $POLICY_KIND db-production

yq --inplace \
    ".spec.parameters.size = \"medium\"" \
    kustomize/overlays/prod/postgresql-crossplane-$PROVIDER.yaml

git add .

git commit -m "DB resize"

git push

kubectl --namespace production get sqlclaims
```

## Continue The Adventure

[TODO:](TODO:)
