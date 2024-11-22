# Progressive Delivery with Istio, and Helm

TODO: Intro

## Setup

> Execute the commands in the section that follows only if you chose Argo CD

```sh
yq --inplace \
    ".spec.source.helm.valuesObject.progressiveDelivery.enabled = true" \
    apps/cncf-demo.yaml

yq --inplace \
    ".spec.source.helm.valuesObject.progressiveDelivery.type = \"$PD_APP\"" \
    apps/cncf-demo.yaml

yq --inplace \
    ".spec.source.helm.valuesObject.istio.enabled = true" \
    apps/cncf-demo.yaml

yq --inplace \
    ".spec.source.helm.valuesObject.istio.host = \"cncf-demo.$ISTIO_HOST\"" \
    apps/cncf-demo.yaml
```

> Execute the command that follows only if you chose Flux

```sh
yq --inplace ".spec.values.progressiveDelivery.enabled = true" \
    apps/cncf-demo.yaml

yq --inplace \
    ".spec.values.progressiveDelivery.type = \"$PD_APP\"" \
    apps/cncf-demo.yaml

yq --inplace ".spec.values.istio.enabled = true" \
    apps/cncf-demo.yaml

yq --inplace \
    ".spec.values.istio.host = \"cncf-demo.$ISTIO_HOST\"" \
    apps/cncf-demo.yaml
```

## Do

> Execute the command that follows only if you chose Argo Rollouts and Argo CD

```bash
yq --inplace ".spec.source.helm.valuesObject.replicas = 0" \
    apps/cncf-demo.yaml
```

> Execute the command that follows only if you chose Argo Rollouts and Flux

```bash
yq --inplace ".spec.values.replicas = 0" apps/cncf-demo.yaml    
```

> Execute the commands in the block that follows only if you chose Argo Rollouts.

```sh
cat helm/app/templates/gateway.yaml

cat helm/app/templates/virtual-service.yaml
```

```sh
cat helm/app/templates/$PD_APP.yaml

cat apps/cncf-demo.yaml

git add .

git commit -m "Progressive delivery"

git push
```

> Execute the command that follows only if you chose Argo Rollouts

```sh
kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```

> Execute the command that follows only if you chose Flagger.

```sh
kubectl --namespace production get canary cncf-demo --watch
```

> It might take a while until resources are synced by Argo CD or Flux. Wait for a while and try again if you seen an error.

> Press `ctrl+c` to stop watching the rollout once it's finished.

> Execute the commands in the block that follows in a second terminal session (in the same directory)

```sh
source .env

hey -z 60m "http://cncf-demo.$ISTIO_HOST"
```

```sh
echo "http://prometheus.$INGRESS_HOST"
```

> Open the URL from the output in a browser.

> Execute the `sum(istio_requests_total{reporter="source",destination_service=~"cncf-demo-primary.production.svc.cluster.local"})` query in the Prometheus UI.

> Execute the `sum(irate(istio_requests_total{reporter="source",destination_service=~"cncf-demo-primary.production.svc.cluster.local",response_code!~"5.*",response_code!~"4.*"}[5m])) / sum(irate(istio_requests_total{reporter="source",destination_service=~"cncf-demo-primary.production.svc.cluster.local"}[5m]))` query in the Prometheus UI.

> Execute the commands in the section that follows only if you chose Argo CD

```sh
yq --inplace \
    ".spec.source.helm.valuesObject.image.tag = \"v0.0.2\"" \
    apps/cncf-demo.yaml
```

> Execute the command that follows only if you chose Flux

```sh
yq --inplace ".spec.values.image.tag = \"v0.0.2\"" \
    apps/cncf-demo.yaml
```

```sh
git add .

git commit -m "Progressive delivery"

git push
```

> Execute the commands in the block that follows in a third terminal session (in the same directory)

```sh
source .env

for i in {1..1000}; do
    sleep 1
    curl "http://cncf-demo.$ISTIO_HOST"
done
```

> Execute the command that follows only if you chose Argo Rollouts.

```sh
kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```

> Execute the command that follows only if you chose Flagger.

```sh
kubectl --namespace production get canaries --watch
```

> Press `ctrl+c` to stop watching the rollout once it's finished.

> Execute the command that follows only if you chose Argo CD.

```sh
yq --inplace \
    ".spec.source.helm.valuesObject.image.tag = \"v0.0.3\"" \
    apps/cncf-demo.yaml
```

> Execute the command that follows only if you chose Flux.

```sh
yq --inplace ".spec.values.image.tag = \"v0.0.3\"" \
    apps/cncf-demo.yaml
```

```sh
git add .

git commit -m "Progressive delivery"

git push
```

> Press `ctrl+c` in the second terminal sesstion to stop watching `hey`.

> Execute the command that follows in the second terminal session

```sh
hey -z 60m "http://cncf-demo.$ISTIO_HOST?fail=true"
```

> Execute the command that follows only if you chose Argo Rollouts.

```sh
kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```

> Execute the command that follows only if you chose Flagger.

```sh
kubectl --namespace production get canaries --watch
```

> Press `ctrl+c` to stop watching processes in all three terminal sessions.

## Continue The Adventure

* [Cloud Cost](../cost/README.md)
