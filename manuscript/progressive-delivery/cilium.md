# Progressive Delivery with Argo Rollouts and Cilium

Argo Rollouts does not work with Cilium which is not a service mesh. Nevertheless, there is nothing preventing us from running a **[service mesh](argo-rollouts.md)** on top of Cilium, so you might want to choose that [option](argo-rollouts.md). Alternatively, Argo Rollouts should work, in a limited capacity, with your Ingress controller of choice.

## Which Ingress Did You Choose?

* **NGINX** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Contour** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Emissary-ingress** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.

