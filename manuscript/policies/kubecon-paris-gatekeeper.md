# Policies with Open Policy Agent (OPA) and Gatekeeper

## Do

```bash
cat policies/gatekeeper-templates.yaml

cp policies/gatekeeper-templates.yaml infra/policy-templates.yaml

git add .

git commit -m "Policy templates"

git push

kubectl get constrainttemplates

# Wait until the contraints templates are created

cat policies/gatekeeper-constraints.yaml

cp policies/gatekeeper-constraints.yaml \
    infra/policy-constraints.yaml

git add .

git commit -m "Policy templates"

git push

kubectl get constraints

export POLICY_KIND=constraints

yq --inplace ".policies.type = \"gatekeeper\"" settings.yaml

yq --inplace ".policies.kind = \"$POLICY_KIND\"" settings.yaml

cp $GITOPS_APP/cncf-demo-$TEMPLATES.yaml apps/cncf-demo.yaml

git add .

git commit -m "CNCF Demo"

git push
```

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel ytt](carvel.md)
* [cdk8s](cdk8s.md)
