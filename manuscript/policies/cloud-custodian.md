# Policies With Cloud Custodian

TODO: Intro

## Setup

```bash
# TODO: kapp-controller

export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cat $GITOPS_APP/cloud-custodian.yaml

cp $GITOPS_APP/cloud-custodian.yaml infra/.

git add . 

git commit -m "Cloud Custodian"

git push

kubectl --namespace c7n-system get pods

# Wait until the Pods are created and are ready
```

## Do

```bash
# TODO: Continue

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
