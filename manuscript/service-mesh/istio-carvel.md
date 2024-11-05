# Progressive Delivery with Istio and Carvel ytt

TODO: Intro

## Setup

```sh
yq --inplace ".istio.enabled = true" ytt/values-prod.yaml

yq --inplace ".istio.host = \"cncf-demo.$ISTIO_HOST\"" \
    ytt/values-prod.yaml
```

## Do

```sh
ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "Progressive delivery"

git push

kubectl --namespace production get virtualservices

hey -z 5m "http://cncf-demo.$ISTIO_HOST"

echo "http://prometheus.$INGRESS_HOST"
```

> Open the URL from the output in a browser.

> Execute the `sum(istio_requests_total{reporter="source",destination_service=~"cncf-demo.production.svc.cluster.local"})` query in the Prometheus UI.

> Execute the `sum(irate(istio_requests_total{reporter="source",destination_service=~"cncf-demo.production.svc.cluster.local",response_code!~"5.*",response_code!~"4.*"}[5m])) / sum(irate(istio_requests_total{reporter="source",destination_service=~"cncf-demo.production.svc.cluster.local"}[5m]))` query in the Prometheus UI.

```sh
echo "http://grafana.$INGRESS_HOST"
```

> Import Dashboards with the IDs `7645`, `7639`, and `7630`

## Continue The Adventure

* [Progressive Delivery](../progressive-delivery/README.md)
