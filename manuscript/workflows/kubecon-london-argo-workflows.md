# One-Shot Actions (Workflows) with Argo Workflows

TODO: Intro

## Setup

> Execute the commands in the next block that follows only if you did **NOT** choose to use Crossplane Compositions.

```sh
cp workflows/devbox-ci.json workflows/Dockerfile \
    workflows/dot.nu cncf-demo-app/.

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
