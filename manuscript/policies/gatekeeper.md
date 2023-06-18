# Policies with Open Policy Agent (OPA) and Gatekeeper

TODO: Intro

## Setup

```bash
export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)
```

## Do

```bash
# Gatekeeper causes issues with Argo CD (not sure about Flux),
#   so we'll install it manually.

helm repo add gatekeeper \
    https://open-policy-agent.github.io/gatekeeper/charts

helm repo update

helm upgrade --install gatekeeper gatekeeper/gatekeeper \
    --namespace gatekeeper-system --create-namespace

# TODO: Continue

cat policies/gatekeeper-templates.yaml

cp policies/gatekeeper-templates.yaml infra/policy-templates.yaml

git add .

git commit -m "Policies"

git push

kubectl get clusterpolicies

# Wait until the policies are created

export POLICY_KIND=deploymentreplicas

yq --inplace ".policies.type = \"gatekeeper\"" settings.yaml

yq --inplace ".policies.kind = \"$POLICY_KIND\"" settings.yaml

TODO: Test SQLClaim
TODO: 
```

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel ytt](carvel.md)
* [cdk8s](cdk8s.md)
