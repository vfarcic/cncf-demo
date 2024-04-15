# Tracing with Jaeger

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/tracing/jaeger.sh

./manuscript/tracing/jaeger.sh
```

## Do

```bash
echo "http://jaeger.$INGRESS_HOST"
```

* Open it in a browser. If it outputs `no healthy upstream`, the Pods are not yet ready. If that's the case, wait for a few moments and refresh the browser.

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel ytt](carvel.md)
* [cdk8s](cdk8s.md)

