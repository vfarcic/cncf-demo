# Develop The Application With DevSpace

TODO: Intro

## Setup

* Install [`devspace` CLI](https://www.devspace.sh/docs/getting-started/installation).

```bash
yq --inplace ".images.app.image = \"$IMAGE\"" devspace.yaml
```

## How Did You Define Your App?

* [Helm](devspace-helm.md)
* [Kustomize](devspace-kustomize.md)
* [Carvel ytt](devspace-carvel.md)
* [cdk8s](devspace-cdk8s.md)