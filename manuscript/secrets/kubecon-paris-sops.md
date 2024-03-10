# Secrets Management Outside Kubernetes With Secrets OPerationS (SOPS)

We could use [KSOPS](https://github.com/viaduct-ai/kustomize-sops), but it works only with Kustomize which might or might not be your choice.

We could use SOPS as an [Argo CD plugin](https://community.ops.io/jilgue/secrets-in-argocd-with-sops-pa6), but that's just silly given that there are better options.

SOPS does work natively with Flux, but you might have choosen Argo CD.

All in all, SOPS is not meant to run in Kubernetes and we do not yet have a "proper" controller for it. So, even though it can be used, we won't use it.

## What Is Your Choice?

* [Istio](../mtls/kubecon-paris-istio.md)
* [Linkerd](../mtls/kubecon-paris-linkerd.md)
* [Cilium and SPIFFE](../mtls/kubecon-paris-cilium.md)