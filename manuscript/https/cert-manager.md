# Use HTTPS With cert-manager

cert-manager is already installed! You installed cert-manager during [setup](/manuscript/setup/dev.md) when you used Helm to install jetstack/cert-manager. You also created an `Issuer` resource when you applied the file [cert-manager/issuer.yaml](/cert-manager/issuer.yaml) to your cluster.

An `Issuer` is a cert-manager custom Kubernetes resource. It tells cert-manager how to connect to a particular CA. cert-manager will obtain certificates from a variety of Issuers, both popular public Issuers as well as private Issuers.

To use HTTPS we still need to define and deploy a `Certificate` resource to our cluster. We'll do that in the next step!

## Setup

* Already installed in the Setup phase.

## How Did You Define Your App?

* [Helm](cert-manager-helm.md)
* [Kustomize](cert-manager-kustomize.md)
* [Carvel ytt](cert-manager-carvel.md)
* [cdk8s](cert-manager-cdk8s.md)