# Setup

```bash
gh repo fork vfarcic/cncf-demo --clone --remote

cd cncf-demo

gh repo set-default

devbox shell

eval "$(teller sh)"

./manuscript/setup/security.sh

# Choose `aws` and `ytt`

source .env

kubectl port-forward svc/argocd-server 8080:80 -n argocd &

# Open http://localhost:8080

./manuscript/policies/kyverno.sh

./manuscript/policies/gatekeeper.sh

./manuscript/policies/kubewarden.sh

./manuscript/runtime-policies/kubearmor.sh

./manuscript/runtime-policies/falco.sh

./manuscript/secrets/eso.sh

./manuscript/secrets/aws.sh

source .env
```

## What Is Your Choice?

* [Kyverno](../policies/kubecon-paris-kyverno.md)
* [Open Policy Agent (OPA) with Gatekeeper](../policies/kubecon-paris-gatekeeper.md)
* [Kubewarden](../policies/kubecon-paris-kubewarden.md)
