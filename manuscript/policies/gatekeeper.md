# Policies with Open Policy Agent (OPA) and Gatekeeper

TODO: Intro

## Setup

```bash
export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)
```

## Do

```bash
cat $GITOPS_APP/gatekeeper.yaml

cp $GITOPS_APP/gatekeeper.yaml infra/.

git add . 

git commit -m "Gatekeeper"

git push

kubectl --namespace gatekeeper-system get pods

# Wait until the Pods are created and are ready

# TODO: Continue rewrite

cat policies/kyverno.yaml

cp policies/kyverno.yaml infra/policies.yaml

git add .

git commit -m "Policies"

git push

kubectl get clusterpolicies

# Wait until the policies are created

export POLICY_KIND=clusterpolicy

yq --inplace ".policies.type = \"kyverno\"" settings.yaml

yq --inplace ".policies.kind = \"$POLICY_KIND\"" settings.yaml
```

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel ytt](carvel.md)
* [cdk8s](cdk8s.md)
