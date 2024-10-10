# Progressive Delivery with Argo Rollouts, Istio, and Helm

TODO: Intro

## Setup

```sh
yq --inplace ".spec.hosts[0] = \"cncf-demo.$ISTIO_HOST\"" \
    kustomize/overlays/prod/virtual-service.yaml
```

## Do

```bash
yq --inplace ".spec.replicas = 0" kustomize/base/deployment.yaml

cat kustomize/overlays/prod/gateway.yaml

cat kustomize/overlays/prod/rollout.yaml

cat kustomize/overlays/prod/virtual-service.yaml

yq --inplace \
    ".spec.source.helm.valuesObject.progressiveDelivery.enabled = true" \
    apps/cncf-demo.yaml

yq --inplace ".resources += \"gateway.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

yq --inplace ".resources += \"rollout.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

yq --inplace ".resources += \"virtual-service.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

git add .

git commit -m "Progressive delivery"

git push

kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```

* If the output claims that `cncf-demo` was not found, GitOps tool of choice did not yet synchronize the Rollout. Wait for a few moments and try again.

FIXME: Continue

```sh
curl "http://cncf-demo.$ISTIO_HOST"

echo "http://prometheus.$INGRESS_HOST"

# Open the URL from the output in a browser

# Execute `sum(irate(istio_requests_total{reporter="source",destination_service=~"cncf-demo-stable.production.svc.cluster.local",response_code!~"5.*"}[5m])) / sum(irate(istio_requests_total{reporter="source",destination_service=~"cncf-demo-stable.production.svc.cluster.local"}[5m]))` query in Prometheus Web UI
```

## Continue The Adventure

The adventure will continue soon. Until then, please [destroy everything](../destroy/observability.md)

