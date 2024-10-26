# Tracing with Jaeger

## Setup

```bash
cat argocd/jaeger.yaml

cp argocd/jaeger.yaml infra/.

git add . 

git commit -m "Prometheus"

git push
```

## Do

```bash
open "http://jaeger.$INGRESS_HOST"
```

## ytt

```bash
yq --inplace ".otel.enabled = true" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml | yq .

git add .

git commit -m "Instrumentation"

git push

kubectl --namespace production get pods
```

* Show it in Jaeger

## What Is Your Choice?

* [Argo Rollouts](../progressive-delivery/kubecon-slc-argo-rollouts.md)
<!-- * [Flagger](../progressive-delivery/kubecon-slc-flagger.md) -->