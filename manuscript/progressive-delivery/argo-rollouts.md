# Progressive Delivery with Argo Rollouts

TODO: Intro

## Setup

* Install [Argo Rollouts Kubectl plugin](https://argo-rollouts.readthedocs.io/en/stable/installation/#manual)
* Install [gum](https://github.com/charmbracelet/gum#installation).
* Watch [How To Create A "Proper" CLI With Shell And Charm Gum](https://youtu.be/U8zCHA-9VLA) if you are not familiar with Charm Gum.

```bash
# TODO: kapp-controller

chmod +x manuscript/progressive-delivery/argo-rollouts.sh

./manuscript/progressive-delivery/argo-rollouts.sh

source .env
```

## Which Service Mesh or Ingress Did You Choose?

* **Cilium** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* [Istio](istio.md)
* **Kuma** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Network Service Mesh** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Linkerd** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
