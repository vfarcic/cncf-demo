# API (CRDs) & State Management (Controllers) Setup

> Watch https://youtu.be/BII6ZY2Rnlc if you are not familiar with GitHub CLI.
> You can skip the command that follows if you already forked the repo and merged it with upstream.

```bash
cd cncf-demo

git pull

devbox shell

eval "$(teller sh)"

./dot.nu setup idp

source .env

./dot.nu setup idp_kubevela $HYPERSCALER

source .env

./dot.nu apply kyverno

./dot.nu apply gatekeeper

./dot.nu setup idp_argocd

./dot.nu apply flux cncf-demo-app

./dot.nu setup idp_argo_workflows $GITHUB_USER $GITHUB_TOKEN
```

## What Is Your Choice?

* [Crossplane](../api/kubecon-london-crossplane.md)
* [KubeVela](../api/kubecon-london-kubevela.md)