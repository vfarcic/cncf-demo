# Progressive Delivery with Istio and Kustomize

TODO: Intro

## Setup

```sh
yq --inplace ".spec.hosts[0] = \"cncf-demo.$ISTIO_HOST\"" \
    kustomize/overlays/prod/virtual-service-no-pd.yaml
```

## Do

```sh
cat kustomize/overlays/prod/virtual-service-no-pd.yaml

cat kustomize/overlays/prod/gateway.yaml

yq --inplace ".resources += \"virtual-service-no-pd.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

yq --inplace ".resources += \"gateway.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

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
