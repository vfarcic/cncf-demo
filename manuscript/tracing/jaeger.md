# Tracing with Jaeger

TODO: Intro

## Setup

> Watch https://youtu.be/WiFLtcBvGMU if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

> Please skip executing `devbox shell` if you are already inside the Shell from one of the previous episodes.

```bash
devbox shell

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

