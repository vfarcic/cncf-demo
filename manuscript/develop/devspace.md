# Develop With DevSpace

TODO: Intro

## Setup

* Install [`devspace` CLI](https://www.devspace.sh/docs/getting-started/installation).

```bash
yq --inplace ".images.app.image = \"$IMAGE\"" devspace.yaml
```

## How Did You Define Your App?

* [Helm](TODO:)
* [Kustomize](devspace-kustomize.md)
* [Carvel](TODO:)