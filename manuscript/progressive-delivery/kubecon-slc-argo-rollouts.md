# Progressive Delivery with Argo Rollouts and Istio

TODO: Intro

## Do

```sh
cat argo-rollouts/istio.yaml

cp argo-rollouts/istio.yaml infra/argo-rollouts-analysis.yaml

git add .

git commit -m "Analysis"

git push

kubectl get clusteranalysistemplates
```

## ytt

```sh
yq --inplace ".progressiveDelivery.enabled = true" \
    ytt/values-prod.yaml

yq --inplace ".progressiveDelivery.type = \"$PD_APP\"" \
    ytt/values-prod.yaml

yq --inplace ".replicas = 0" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "Progressive delivery"

git push

kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch

hey -z 60m "http://cncf-demo.$ISTIO_HOST"
```

```sh
open "http://prometheus.$INGRESS_HOST"
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

for i in {1..1000}; do
    sleep 1
    curl "http://cncf-demo.$ISTIO_HOST"
done

kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch

yq --inplace ".image.tag = \"v0.0.3\"" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "Progressive delivery"

git push

hey -z 60m "http://cncf-demo.$ISTIO_HOST?fail=true"

kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```
