# Policies With Kubewarden

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
# TODO: kapp-controller

chmod +x manuscript/policies/kubewarden.sh

./manuscript/policies/kubewarden.sh

source .env
```

## Do

```bash
cat policies/kubewarden.yaml

cp policies/kubewarden.yaml infra/policies.yaml

git add .

git commit -m "Policies"

git push

kubectl get clusteradmissionpolicies

# Wait until the policies are created

kubectl --namespace production get admissionpolicies

# Wait until the policies are created

export POLICY_KIND=admissionpolicy

yq --inplace ".policies.type = \"kubewarden\"" settings.yaml

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
