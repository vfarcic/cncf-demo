# Policies With Carvel ytt

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/policies/carvel.sh

./manuscript/policies/carvel.sh

source .env
```

## Do

```bash
# TODO: kapp-controller

cp $GITOPS_APP/cncf-demo-ytt.yaml apps/cncf-demo.yaml

git add .

git commit -m "CNCF Demo"

git push

kubectl --namespace production get statefulsets

# Wait until the StatefulSet is created

kubectl --namespace production get deployments

# The Deployment was NOT created

# If Gatekeeper
export POLICY_KIND=deploymentreplicas

kubectl describe $POLICY_KIND deploymentproduction

# Gatekeeper does not show violations, but it does enforce them.

yq --inplace ".replicas = 3" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "CNCF Demo scaled"

git push

kubectl --namespace production get deployments

# Wait until the Deployment is created

kubectl --namespace production get pods

# Pods are not be running since the database was not created and,
#   with it, the Secret with the authentication was not created
#   either, hence the Pods that require the Secret are not
#   starting).

kubectl --namespace production get sqlclaims

# The SqlClaim was NOT created

# If Gatekeeper
export POLICY_KIND=dbsize

kubectl describe $POLICY_KIND dbcluster

kubectl describe $POLICY_KIND dbproduction

# Gatekeeper (still) does not show violations, but it does
#   enforce them.

yq --inplace ".db.size = \"medium\"" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "DB resize"

git push

kubectl --namespace production get sqlclaims

# Wait until the SqlClaim is created

kubectl --namespace production wait sqlclaim cncf-demo \
    --for=condition=ready --timeout=15m
```

## Continue The Adventure

* [Runtime Policies](../runtime-policies/README.md)
