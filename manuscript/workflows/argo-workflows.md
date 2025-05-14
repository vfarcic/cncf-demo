# One-Shot Actions (Workflows) with Argo Workflows

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
./dot.nu setup idp_argo_workflows $GITHUB_USER $GITHUB_TOKEN

cp workflows/* cncf-demo-app/.
```

> Execute the command that follows only if you chose **KubeVela**.

```sh
mv cncf-demo-app/dot-kubevela.nu cncf-demo-app/dot.nu
```

```sh
cd cncf-demo-app

git add .

git commit -m "CI"

git pull

git push

cd ..
```

## Do

```sh
cat workflows/argo.yaml

kubectl --namespace argo port-forward service/argo-server 2746:2746
```

> Open https://localhost:2746 in a browser.
> Stop port forwarding by pressing `ctrl+c`. We'll observe workflow runs from the terminal.

```sh
argo submit --namespace argo workflows/argo.yaml \
    --parameter registry-user=$GITHUB_USER --watch

argo list --namespace argo

argo get --namespace argo @latest

argo logs --namespace argo @latest
```

```sh
echo "https://github.com/users/$GITHUB_USER/packages/container/package/cncf-demo-app"
```

> Open the URL from the output of the previous command in a browser.

> Clicks the `Package settings` button from the right-hand menu and `Change visibility` to `Public`.

```sh
cd cncf-demo-app

git pull

cat apps/silly-demo.yaml

kubectl --namespace production get all,ingresses

cd ..
```

> We should use Argo Events to trigger Argo Workflows from GitHub.

## Continue The Adventure

* [Graphical User Interface (GUI)](../gui/README.md)
