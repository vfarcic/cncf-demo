# Setup

```bash
gh repo fork vfarcic/cncf-demo --clone --remote

cd cncf-demo

gh repo set-default

devbox shell

PS1="➜ "

eval "$(teller sh)"

./manuscript/setup/security.sh

# Choose `aws` and `ytt`

source .env

kubectl port-forward svc/argocd-server 8080:80 -n argocd

# Open http://localhost:8080

./manuscript/policies/kyverno.sh

# Wait until it is synced by Argo CD

./manuscript/policies/gatekeeper.sh

# Wait until it is synced by Argo CD

./manuscript/policies/kubewarden.sh

# Wait until it is synced by Argo CD

./manuscript/runtime-policies/kubearmor.sh

# Wait until it is synced by Argo CD

./manuscript/runtime-policies/falco.sh

# Wait until it is synced by Argo CD

./manuscript/secrets/eso.sh

# Wait until it is synced by Argo CD

./manuscript/secrets/aws.sh

# Wait until it is synced by Argo CD

./manuscript/mtls/istio.sh

# Wait until it is synced by Argo CD

curl --proto '=https' --tlsv1.2 \
    -sSfL https://run.linkerd.io/install | sh

linkerd check --pre

linkerd install --crds | kubectl apply --filename -

linkerd install | kubectl apply --filename -

linkerd viz install | kubectl apply --filename -

linkerd check

./manuscript/mtls/cilium.sh

# Wait until it is synced by Argo CD

source .env
```

## Checklist

Admission Controller Policies:
* OPA
* Kyverno
* Kubewarden

Runtime Policies:
* Falco
* KubeArmor

Secrets Management:
* ESO
* SSCSI
* SOPS

mTLS & Network Policies:
* Cilium
* Linkerd
* Istio

## What Is Your Choice?

* [Kyverno](../policies/kubecon-paris-kyverno.md)
* [Open Policy Agent (OPA) with Gatekeeper](../policies/kubecon-paris-gatekeeper.md)
* [Kubewarden](../policies/kubecon-paris-kubewarden.md)
