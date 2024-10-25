# Metrics With Prometheus

## Setup

```bash
helm upgrade --install \
    kube-prometheus-stack kube-prometheus-stack \
    --repo https://prometheus-community.github.io/helm-charts \
    --values prometheus/values.yaml --reuse-values \
    --namespace monitoring --create-namespace --wait
```

## Do

```sh
hey -z 5m "http://cncf-demo.$INGRESS_HOST"

open "http://prometheus.$INGRESS_HOST"

open "http://grafana.$INGRESS_HOST"
```

* Open it in a browser
* Use `admin` as the user and `prom-operator` as the password
* Explore dashboards

## Continue the Adventure

* [Jaeger](../tracing/kubecon-slc-jaeger.md)
