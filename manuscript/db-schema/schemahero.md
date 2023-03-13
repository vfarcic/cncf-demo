# Manage DB Schema with SchemaHero

Let's install SchemaHero with `krew`, the kubectl plugin tool! You can use `krew` to install and upgrade SchemaHero, and also to interact with SchemaHero objects.

## Setup

## Setup

* Install `krew` from https://krew.sigs.k8s.io/docs/user-guide/setup/install

```bash
kubectl krew install schemahero

export PATH="${PATH}:${HOME}/.krew/bin"

kubectl schemahero install
```

## How Did You Define Your App?

* [Helm](schemahero-helm.md)
* [Kustomize](schemahero-kustomize.md)
* [Carvel](schemahero-carvel.md)
* [cdk8s](schemahero-cdk8s.md)