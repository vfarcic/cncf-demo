# Policies With Validating Admission Policy

TODO: Intro

## Setup

At this moment (June 2023), Validating Admission Policy is available as a beta feature hence it needs to be enabled in Kubernetes.
If you setup the cluster following the setup instructions of this chapter, alpha features are already enabled.
Otheriwse, you might need to enable it yourself.

```bash
export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)
```

## Do

```bash
kubectl api-resources | grep ValidatingAdmissionPolicy

cat policies/vap.yaml

cp policies/vap.yaml infra/policies.yaml

git add .

git commit -m "Policies"

git push

kubectl get validatingadmissionpolicies

# Wait until the policies are created

export POLICY_KIND=validatingadmissionpolicies

yq --inplace ".policies.type = \"vap\"" settings.yaml

yq --inplace ".policies.kind = \"$POLICY_KIND\"" settings.yaml
```

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel ytt](carvel.md)
* [cdk8s](cdk8s.md)
