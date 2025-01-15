# State Synchronization (GitOps) with Flux

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
./dot.nu apply flux cncf-demo-app
```

## Do

```sh
kubectl --namespace production delete \
    --filename cncf-demo-app/apps/silly-demo.yaml

cat flux/apps-idp.yaml

kubectl --namespace production get all,ingresses

kubectl apply --filename flux/apps-idp.yaml

kubectl --namespace production get all,ingresses
```

> The Pod `STATUS` is still `ErrImagePull` or `ImagePullBackOff` because there is no image. We'll fix that later.

## Continue The Adventure

* [One-Shot Actions (Workflows)](../workflows/README.md)
