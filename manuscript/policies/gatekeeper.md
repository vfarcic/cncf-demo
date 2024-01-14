# Policies with Open Policy Agent (OPA) and Gatekeeper

In OPA Gatekeeper, a *Constraint* is a declaration for a system to meet a given set of requirements. Each Constraint is written with Rego, a declarative query language used by OPA.

Before defining a Constraint, you need to create a *Constraint Template*. A Constraint Template allows people to declare new Constraints. Each template has two elements:
* The Rego logic that enforces the Constraint
* The schema for the Constraint

Once you apply the Constraint Template, then you are able to create individual Constraint CRDs that comply with your Constraint Template.


## Setup

```bash
rm -f apps/cncf-demo.yaml

git add .

git commit -m "CNCF Demo"

git push

# Gatekeeper causes issues with Argo CD (not sure about Flux),
#   so we'll install it manually.

helm repo add gatekeeper \
    https://open-policy-agent.github.io/gatekeeper/charts

helm repo update

helm upgrade --install gatekeeper gatekeeper/gatekeeper \
    --namespace gatekeeper-system --create-namespace --wait
```

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
