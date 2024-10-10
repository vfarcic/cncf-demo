# Progressive Delivery with Argo Rollouts, Istio, and Helm

TODO: Intro

## Do

```bash
# Execute the command that follows only if you are using Argo CD
yq --inplace ".spec.source.helm.valuesObject.replicas = 0" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Flux
yq --inplace ".spec.values.replicas = 0" apps/cncf-demo.yaml

cat helm/app/templates/argo-rollouts.yaml

# Execute the command that follows only if you are using Argo CD
yq --inplace \
    ".spec.source.helm.valuesObject.progressiveDelivery.enabled = true" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Flux
yq --inplace ".spec.values.progressiveDelivery.enabled = true" \
    apps/cncf-demo.yaml

git add .

git commit -m "Progressive delivery"

git push

kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```

* If the output claims that `cncf-demo` was not found, GitOps tool of choice did not yet synchronize the Rollout. Wait for a few moments and try again.

```sh
curl http://cncf-demo.$ISTIO_HOST

echo "http://prometheus.$INGRESS_HOST"

# Open the URL from the output in a browser

# Execute `sum(irate(istio_requests_total{reporter="source",destination_service=~"cncf-demo-stable.production.svc.cluster.local",response_code!~"5.*"}[5m])) / sum(irate(istio_requests_total{reporter="source",destination_service=~"cncf-demo-stable.production.svc.cluster.local"}[5m]))` query in Prometheus Web UI
```

## Continue The Adventure

The adventure will continue soon. Until then, please [destroy everything](../destroy/observability.md)

