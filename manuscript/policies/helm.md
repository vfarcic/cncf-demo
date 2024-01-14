# Policies With Helm

TODO: Intro

## Do

```bash
# TODO: kapp-controller

kubectl --namespace production get deployments

# The Deployment was NOT created

# If Gatekeeper
export POLICY_KIND=deploymentreplicas

kubectl describe $POLICY_KIND deploymentproduction

# Gatekeeper does not show violations, but it does enforce them.

cat apps/cncf-demo.yaml

# If Argo CD
yq --inplace ".spec.source.helm.parameters[9].value = \"3\"" \
    apps/cncf-demo.yaml

# If Flux
yq --inplace ".spec.values.replicas = 3" apps/cncf-demo.yaml

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

# Gatekeeper (still) does not show violations, but it does
#   enforce them.

cat apps/cncf-demo.yaml

# If Argo CD
yq --inplace \
    ".spec.source.helm.parameters[10].value = \"medium\"" \
    apps/cncf-demo.yaml

# If Flux
yq --inplace ".spec.values.db.size = small" apps/cncf-demo.yaml

git add .

git commit -m "DB resize"

git push

kubectl --namespace production get sqlclaims

# Wait until the SqlClaim is created

kubectl --namespace production wait sqlclaim cncf-demo \
    --for=condition=ready --timeout=15m
```

## Continue The Adventure

The adventure will continue soon...

In the meantime... [Destroy Everything](../destroy/security.md)