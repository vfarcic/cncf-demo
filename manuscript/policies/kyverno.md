# Policies With Kyverno

TODO: Intro

## Setup

```bash
export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)
```

## Do

```bash
cat $GITOPS_APP/kyverno.yaml

cp $GITOPS_APP/kyverno.yaml infra/.

git add . 

git commit -m "Kyverno"

git push

kubectl --namespace kyverno get all

cat policies/kyverno.yaml

cp policies/kyverno.yaml infra/policies.yaml

git add . 

git commit -m "Policies"

git push

kubectl get clusterpolicies

# TODO: Validate Deployment
# TODO: Validate DB
# TODO: Mutate
# TODO: Validate image
# TODO: Generate
```

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel](carvel.md)
* [cdk8s](cdk8s.md)
