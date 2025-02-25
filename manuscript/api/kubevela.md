# API (CRDs) & State Management (Controllers) With KubeVela

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
./dot.nu setup idp_kubevela $HYPERSCALER

source .env
```

## Do

```sh
cd cncf-demo-app

cp ../kubevela/$HYPERSCALER-sql.yaml apps/silly-demo-db.yaml

cp ../kubevela/$HYPERSCALER-sql-password.yaml \
    apps/silly-demo-db-password.yaml

cat apps/silly-demo-db-password.yaml

cat apps/silly-demo-db.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo-db-password.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo-db.yaml

kubectl get managed

cp ../kubevela/app.yaml apps/silly-demo.yaml

cat apps/silly-demo.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo.yaml

kubectl --namespace production get all,ingresses
```

> The Pod `STATUS` is `ErrImagePull` because there is no image. We'll fix that later.

```sh
vela delete silly-demo --yes

cat ../kubevela/component-app-backend.cue

cat ../kubevela/component-db-$HYPERSCALER.cue

git add .

git commit -m "Apps"

git pull

git push

cd ..
```

## Continue The Adventure

* [Policies](../policies-idp/README.md)
