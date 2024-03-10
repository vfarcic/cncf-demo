# Policies With Kyverno

## Do

```bash
cp policies/kyverno.yaml infra/policies.yaml

git add .

git commit -m "Policies"

git push

cat policies/kyverno.yaml

kubectl get clusterpolicies

# Wait until the policies are created

cp argocd/cncf-demo-ytt.yaml apps/cncf-demo.yaml

git add .

git commit -m "CNCF Demo"

git push

# TODO: kapp-controller

kubectl --namespace production get deployments

# The Deployment was NOT created

kubectl describe clusterpolicy deploymentproduction

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

kubectl describe clusterpolicy dbcluster

kubectl describe clusterpolicy dbproduction

# Gatekeeper (still) does not show violations, but it does
#   enforce them.

yq --inplace ".db.size = \"medium\"" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "DB resize"

git push

kubectl --namespace production get sqlclaims
```

## Continue The Adventure

* [KubeArmor](../runtime-policies/kubecon-paris-kubearmor.md)
* [Falco](../runtime-policies/kubecon-paris-falco.md)
