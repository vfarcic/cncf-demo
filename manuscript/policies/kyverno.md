# Policies With Kyverno

TODO: Intro

## Setup

```bash
# TODO: kapp-controller

export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cat $GITOPS_APP/kyverno.yaml

cp $GITOPS_APP/kyverno.yaml infra/.

git add . 

git commit -m "Kyverno"

git push

kubectl --namespace kyverno get pods

# Wait until the Pods are created and ready
```

## Do

```bash
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
