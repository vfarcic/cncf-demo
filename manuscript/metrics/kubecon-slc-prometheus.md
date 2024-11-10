# Metrics With Prometheus

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
