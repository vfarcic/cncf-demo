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

export GITHUB_USER=vfarcic

./dot.nu setup idp_kubevela $HYPERSCALER

source .env

./dot.nu apply kyverno

# ./dot.nu apply gatekeeper

./dot.nu setup idp_argocd

# ./dot.nu apply flux cncf-demo-app

export EMAIL=viktor@farcic.com

./dot.nu setup idp_argo_workflows $GITHUB_USER $GITHUB_TOKEN

./dot.nu apply backstage "0.0.3" \
    --ingress_host "backstage.$INGRESS_HOST" \
    --github_token $GITHUB_TOKEN \
    --create_service_account true

source .env

cp workflows/* cncf-demo-app/.
```

## What Is Your Choice?

* [Crossplane](../api/kubecon-london-crossplane.md)
* [KubeVela](../api/kubecon-london-kubevela.md)