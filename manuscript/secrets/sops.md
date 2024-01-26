# Secrets Management Outside Kubernetes With Secrets OPerationS (SOPS)

TODO: Intro

## Setup

* Install `sops` by following the instructions on the latest release: https://github.com/getsops/sops/releases

```bash
chmod +x manuscript/secrets/sops.sh

./manuscript/secrets/sops.sh

source .env
```

## Which GitOps Tool Did You Choose?

* [Argo CD](sops-argocd.md)
* [Flux](sops-flux.md)
* [Carvel kapp-controller](sops-kapp.md)
