# Managing Secrets In Kubernetes With Secrets Store CSI Driver (SSCSID)

Secrets Store CSI Driver (SSCSID) cannot create secrets.
It mounts volumes instead of secrets, which is great for first party apps that can mount volumes instead of secrets.
We need to use secrets for the rest of the adventure, so SSCSID is not a good choice.

## What Is Your Choice?

* [Istio](../mtls/kubecon-paris-istio.md)
* [Linkerd](../mtls/kubecon-paris-linkerd.md)
* [Cilium and SPIFFE](../mtls/kubecon-paris-cilium.md)
