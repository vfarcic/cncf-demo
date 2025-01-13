# Policies with Kyverno

TODO: Intro

## Setup

> Watch [Nix for Everyone: Unleash Devbox for Simplified Development](https://youtu.be/WiFLtcBvGMU) if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

> Skip executing `devbox shell` if you are already inside the Shell from one of the previous episodes.

```bash
devbox shell

source .env
```

> Watch [The Future of Shells with Nushell! Shell + Data + Programming Language](https://youtu.be/zoX_S6d-XU4) if you are not familiar with Nushell. Alternatively, you can inspect the `dot.nu` script and transform the instructions in it to Bash or ZShell if you prefer not to use that Nushell script.

```sh
./dot.nu apply kyverno
```

## Do

```sh
cat policies/kyverno-idp-$API.yaml

kubectl apply --filename policies/kyverno-idp-$API.yaml

kubectl --namespace production apply \
    --filename cncf-demo-app/apps/silly-demo.yaml

yq --inplace ".spec.components[0].traits[0].type = \"scaler\"" \
    cncf-demo-app/apps/silly-demo.yaml

kubectl --namespace production apply \
    --filename cncf-demo-app/apps/silly-demo.yaml

yq --inplace ".spec.components[0].traits[0].properties.min = 2" \
    cncf-demo-app/apps/silly-demo.yaml

kubectl --namespace production apply \
    --filename cncf-demo-app/apps/silly-demo.yaml
```

## Continue The Adventure

* [State Synchronization (GitOps)](../gitops-idp/README.md)
