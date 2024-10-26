# Progressive Delivery with Argo Rollouts, Istio, and Carvel ytt

TODO: Intro

## ytt

```sh
yq --inplace ".progressiveDelivery.enabled = true" \
    ytt/values-prod.yaml

yq --inplace ".progressiveDelivery.type = \"$PD_APP\"" \
    ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "Progressive delivery"

git push

kubectl --namespace production get canaries --watch

hey -z 60m "http://cncf-demo.$ISTIO_HOST"

open "http://prometheus.$INGRESS_HOST"
```

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

kubectl --namespace production get canaries --watch

yq --inplace ".image.tag = \"v0.0.3\"" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "Progressive delivery"

git push

hey -z 60m "http://cncf-demo.$ISTIO_HOST?fail=true"

kubectl --namespace production get canaries --watch

kubectl --namespace production describe canary cncf-demo
```

