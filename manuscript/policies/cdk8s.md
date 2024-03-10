# Policies With Kustomize

TODO: Intro

## Do

```bash
# TODO: kapp-controller

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

# Gatekeeper does not show violations, but it does enforce them.

yq --inplace ".replicas = 3" cdk8s/app-prod.yaml

cd cdk8s

ENVIRONMENT=prod cdk8s synth --output ../yaml/prod --validate

cd ..

git add .

git commit -m "CNCF Demo scaled"

git push

kubectl --namespace production get deployments

# Wait until the Deployment is created
# It might take a while until Argo CD gives up on trying to
#   reconcile the previous commit.

kubectl --namespace production get pods

# Pods are not be running since the database was not created and,
#   with it, the Secret with the authentication was not created
#   either, hence the Pods that require the Secret are not
#   starting).

kubectl --namespace production get sqlclaims

# The SqlClaim was NOT created

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

yq --inplace ".db.size = \"medium\"" cdk8s/app-prod.yaml

cd cdk8s

ENVIRONMENT=prod cdk8s synth --output ../yaml/prod --validate

cd ..

git add .

git commit -m "DB resize"

git push

kubectl --namespace production get sqlclaims

kubectl --namespace production wait sqlclaim cncf-demo \
    --for=condition=ready --timeout=15m
```

## Continue The Adventure

* [Runtime Policies](../runtime-policies/README.md)
