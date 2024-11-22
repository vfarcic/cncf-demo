# Progressive Delivery with Istio and Carvel ytt

TODO: Intro

## Setup

```sh
yq --inplace ".progressiveDelivery.enabled = true" \
    ytt/values-prod.yaml

yq --inplace ".progressiveDelivery.type = \"$PD_APP\"" \
    ytt/values-prod.yaml
```

## Do

> Execute the command that follows only if you chose **Argo Rollouts**.

```bash
yq --inplace ".replicas = 0" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "Progressive delivery"

git push
```

> Execute the command that follows only if you chose **Argo Rollouts**.

```sh
kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```

> Execute the command that follows only if you chose **Flagger**.

```sh
kubectl --namespace production get canaries --watch
```

> Press `ctrl+c` to stop watching the rollout once it's finished.

> Execute the command that follows in a second terminal session (in the same directory)

```sh
source .env
```

> Execute the command that follows in the second terminal session

```sh
hey -z 60m "http://cncf-demo.$ISTIO_HOST"
```

```sh
echo "http://prometheus.$INGRESS_HOST"
```

> Open the URL from the output in a browser.

> Execute the `sum(istio_requests_total{reporter="source",destination_service=~"cncf-demo-primary.production.svc.cluster.local"})` query in the Prometheus UI.

> Execute the `sum(irate(istio_requests_total{reporter="source",destination_service=~"cncf-demo-primary.production.svc.cluster.local",response_code!~"5.*",response_code!~"4.*"}[5m])) / sum(irate(istio_requests_total{reporter="source",destination_service=~"cncf-demo-primary.production.svc.cluster.local"}[5m]))` query in the Prometheus UI.

```sh
yq --inplace ".image.tag = \"v0.0.2\"" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "Progressive delivery"

git push
```

> Execute the command that follows in a third terminal session (in the same directory)

```sh
source .env
```

> Execute the command that follows in the third terminal session

```sh
for i in {1..1000}; do
    sleep 1
    curl "http://cncf-demo.$ISTIO_HOST"
done
```

> Execute the command that follows only if you chose **Argo Rollouts**.

```sh
kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```

> Execute the command that follows only if you chose **Flagger**.

```sh
kubectl --namespace production get canaries --watch
```

> Press `ctrl+c` to stop watching the rollout once it's finished.

```sh
yq --inplace ".image.tag = \"v0.0.3\"" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "Progressive delivery"

git push
```

> Press `ctrl+c` in the third terminal sesstion to stop watching `hey`.

> Execute the command that follows in the second terminal session

```sh
hey -z 60m "http://cncf-demo.$ISTIO_HOST?fail=true"
```

> Execute the command that follows only if you chose **Argo Rollouts**.

```sh
kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```

> Execute the command that follows only if you chose **Flagger**.

```sh
kubectl --namespace production get canaries --watch
```

> Press `ctrl+c` to stop watching processes in all three terminal sessions.

## Continue The Adventure

* [Cloud Cost](../cost/README.md)

