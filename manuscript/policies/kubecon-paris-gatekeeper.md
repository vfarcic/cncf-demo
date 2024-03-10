# Policies with Open Policy Agent (OPA) and Gatekeeper

## Do

```bash
cp policies/gatekeeper-templates.yaml infra/policy-templates.yaml

git add .

git commit -m "Policy templates"

git push

cat policies/gatekeeper-templates.yaml

kubectl get constrainttemplates

# Wait until the contraints templates are created

cat policies/gatekeeper-constraints.yaml

cp policies/gatekeeper-constraints.yaml \
    infra/policy-constraints.yaml

git add .

git commit -m "Policy templates"

git push

kubectl get constraints

cp $GITOPS_APP/cncf-demo-$TEMPLATES.yaml apps/cncf-demo.yaml

git add .

git commit -m "CNCF Demo"

git push

kubectl --namespace production get deployments

# The Deployment was NOT created

kubectl describe deploymentreplicas deploymentproduction

# Gatekeeper does not show violations, but it does enforce them.

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

kubectl describe dbsize dbcluster

kubectl describe dbsize dbproduction

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
