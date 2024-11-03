# Progressive Delivery with Argo Rollouts

TODO: Intro

## Setup

> Please skip executing `devbox shell` if you are already inside the Shell from one of the previous episodes.

```bash
devbox shell

# TODO: kapp-controller
# TODO: Flux

chmod +x manuscript/progressive-delivery/flagger.sh

./manuscript/progressive-delivery/flagger.sh

source .env
```

## Which Service Mesh or Ingress Did You Choose?

* **Cilium** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* [Istio](istio.md)
* **Kuma** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Network Service Mesh** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Linkerd** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
