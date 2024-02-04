# Manage DB Schema with SchemaHero

Let's install SchemaHero with `krew`, the kubectl plugin tool! You can use `krew` to install and upgrade SchemaHero, and also to interact with SchemaHero objects.

## Setup

* Install `krew` from https://krew.sigs.k8s.io/docs/user-guide/setup/install

```bash
chmod +x manuscript/db-schema/schemahero.sh

./manuscript/db-schema/schemahero.sh
```

## How Did You Define Your App?

* [Helm](schemahero-helm.md)
* [Kustomize](schemahero-kustomize.md)
* [Carvel ytt](schemahero-carvel.md)
* [cdk8s](schemahero-cdk8s.md)
