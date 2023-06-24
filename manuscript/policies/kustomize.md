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
# TODO: kapp-controller

cp $GITOPS_APP/cncf-demo-kustomize.yaml apps/cncf-demo.yaml

git add .

git commit -m "CNCF Demo"

git push

kubectl --namespace production get all

# Wait until resources are created

kubectl --namespace production get deployments

# The Deployment was NOT created

# If Gatekeeper
export POLICY_KIND=deploymentreplicas

# TODO: Figure out why Gatekeeper does not show but does enforce
#   violations.
kubectl describe $POLICY_KIND deploymentproduction

cat kustomize/overlays/prod/deployment-scaled.yaml

yq --inplace \
    ".patchesStrategicMerge += \"deployment-scaled.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

git add .

git commit -m "CNCF Demo scaled"

git push

kubectl --namespace production get deployments

# Wait until the Deployment is created

# Pods are not be running since the database was not created and,
#   with it, the Secret with the authentication was not created
#   either, hence the Pods that require the Secret are not
#   starting).

kubectl --namespace production get sqlclaims

# The SqlClaim was NOT created

# If Gatekeeper
export POLICY_KIND=deploymentreplicas

kubectl describe $POLICY_KIND dbcluster

kubectl describe $POLICY_KIND dbproduction

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

[Runtime Policies](../runtime-policies/README.md)
