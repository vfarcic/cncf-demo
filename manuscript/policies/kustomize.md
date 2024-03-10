# Policies With Kustomize

TODO: Intro

## Do

```bash
# TODO: kapp-controller

kubectl --namespace production get svc

# Wait until the `cncf-demo` Service is created

kubectl --namespace production get deployments

# The Deployment was NOT created

# If Gatekeeper
export POLICY_KIND=deploymentreplicas

# If Gatekeeper or Kyverno
kubectl describe $POLICY_KIND deploymentproduction

# If Kubewarden
kubectl --namespace production \
    describe $POLICY_KIND deploymentproduction

# Gatekeeper and KubeWarden do not show violations, but they do enforce them.

cat kustomize/overlays/prod/deployment-scaled.yaml

yq --inplace \
    ".patchesStrategicMerge += \"deployment-scaled.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

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

# The SqlClaim was NOT created or it's not synced.

# If Gatekeeper
export POLICY_KIND=dbsize

# If Gatekeeper or Kyverno
kubectl describe $POLICY_KIND dbcluster

# If Kubewarden
kubectl describe clusteradmissionpolicy dbcluster

# If Gatekeeper or Kyverno
kubectl describe $POLICY_KIND dbproduction

# If Kubewarden
kubectl --namespace production \
    describe admissionpolicy dbproduction

# Gatekeeper and Kubewarden (still) do not show violations, but they do enforce them.

cat kustomize/overlays/prod/postgresql-crossplane-$HYPERSCALER.yaml

yq --inplace \
    ".spec.parameters.size = \"medium\"" \
    kustomize/overlays/prod/postgresql-crossplane-$HYPERSCALER.yaml

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
