# Progressive Delivery with Argo Rollouts and Cilium

Argo Rollouts does not work with Cilium which is not a service mesh. Nevertheless, Argo Rollouts should work, in a limited capacity, with your Ingress controller of choice. Alternatively, you might want to choose a [service mesh](argo-rollouts.md) (recommended).

## Which Ingress Did You Choose?

* **NGINX** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Contour** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Emissary-ingress** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.

