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

export DESTINATION=$(yq ".crossplane.destination" settings.yaml)
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

kubectl --namespace production get deployments

# Wait until the Deployment is created

# If you started from this chapter (Production), the Pods
#   will not be running since Crossplane is not configured to
#   manage Cloud resources so the database was not created and,
#   with it, the Secret with the authentication was not created
#   either, hence the Pods that require the Secret are not
#   starting).

kubectl --namespace production get sqlclaims

kubectl describe $POLICY_KIND db-cluster

kubectl describe $POLICY_KIND db-production

cat kustomize/overlays/prod/postgresql-crossplane-$DESTINATION.yaml

yq --inplace \
    ".spec.parameters.size = \"medium\"" \
    kustomize/overlays/prod/postgresql-crossplane-$DESTINATION.yaml

git add .

git commit -m "DB resize"

git push

kubectl --namespace production get sqlclaims

# Wait until the claim is created
```

## Continue The Adventure

[Managing Secrets](../secrets/README.md)
