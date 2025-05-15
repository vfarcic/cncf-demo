# One-Shot Actions (Workflows) with Argo Workflows

TODO: Intro

## Setup

```sh
./manuscript/workflows/argo-workflows.sh
```

## Do

```sh
cat workflows/argo.yaml

argo submit --namespace argo workflows/argo.yaml \
    --parameter registry-user=$GITHUB_USER --watch

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
