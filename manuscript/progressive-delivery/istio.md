# Progressive Delivery with Argo Rollouts and Istio

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
# TODO: kapp-controller
```

* Execute `prometheus.sh` script only if you did NOT already install Prometheus.

```sh
chmod +x manuscript/metrics/prometheus.sh

./manuscript/metrics/prometheus.sh
```

* Execute `istio.sh` script only if you did NOT already install Istio

```sh
chmod +x manuscript/mtls/istio.sh

./manuscript/mtls/istio.sh

source .env
```

## How Did You Define Your App?

* **Kustomize** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Helm** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Carvel ytt** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **cdk8s** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.

<!--
## Continue The Adventure

The adventure will continue soon. Until then, please [destroy everything](../destroy/observability.md)
-->