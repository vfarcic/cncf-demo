# Policies With Carvel ytt

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

yq --inplace ".replicas = 3" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "CNCF Demo scaled"

git push

# In case of Argo CD, it might take a while until the previous sync times out and a new one starts.
# You can speed it up by opening the app in Argo CD and clicking the `SYNC STATUS` button follows by `TERMINATE`.

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

yq --inplace ".db.size = \"medium\"" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "DB resize"

git push

# In case of Argo CD, it might take a while until the previous sync times out and a new one starts.
# You can speed it up by opening the app in Argo CD and clicking the `SYNC STATUS` button follows by `TERMINATE`.

kubectl --namespace production get sqlclaims

# Wait until the SqlClaim is created

kubectl --namespace production wait sqlclaim cncf-demo \
    --for=condition=ready --timeout=15m
```

## Continue The Adventure

* [Runtime Policies](../runtime-policies/README.md)
