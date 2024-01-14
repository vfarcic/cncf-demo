# Policies With Cloud Custodian

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/policies/cloud-custodian.sh

./manuscript/policies/cloud-custodian.sh
```
## Do

```bash
kubectl --namespace production get deployments

# Wait until the `cncf-demo` Deployment is created

source custodian/bin/activate

custodian run --output-dir=output policies/cloud-custodian.yaml \
    --cache-period 0

custodian run --output-dir=output policies/cloud-custodian.yaml \
    --cache-period 0 --verbose
```

## How Did You Define Your App?

* **Helm** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* [Kustomize](cloud-custodian-kustomize.md)
* **Carvel ytt** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **cdk8s** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
