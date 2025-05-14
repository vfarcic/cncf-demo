# One-Shot Actions (Workflows) with Argo Workflows

TODO: Intro

## Setup

```sh
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

cd cncf-demo-app

git pull

cat apps/silly-demo.yaml

kubectl --namespace production get all,ingresses

cd ..
```

> We should use Argo Events to trigger Argo Workflows from GitHub.

## Continue The Adventure

* [Backstage](../gui/kubecon-london-backstage.md)
