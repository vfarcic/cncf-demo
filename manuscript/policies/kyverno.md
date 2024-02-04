# Policies With Kyverno

There are five main capabilities of Kyverno:

* **Resource Validation**
<br>
-Is it allowed? - 'Yes' or 'No' response
<br>
-'No' usually includes a custom message about WHY

* **Resource Mutation**
<br>
-Should the resource be changed? If so, how?
<br>
-Good for adding information that is only known at runtime

* **Resource Generation**
<br>
-Kyverno can create new Kubernetes resources
<br>
-For example, if a new namespace is created, clone a specific secret
<br>
*Resource generation enables multitenancy*

* **Software Supply Chain**
<br>
-Kyverno has a rule type 'Verify Images' that can verify signatures & verify attestations
<br>
-Secures container images and other OCI artifacts
<br>
*Verify images supports both Sigstore and Notary*

* **Resource Clean Up**
<br>
-Clean up any resource
<br>
-For example, remove old pods based on age


## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
# TODO: kapp-controller

chmod +x manuscript/policies/kyverno.sh

./manuscript/policies/kyverno.sh

source .env
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
