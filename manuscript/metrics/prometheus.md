# Metrics With Prometheus

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/metrics/prometheus.sh

./manuscript/metrics/prometheus.sh
```

## Do

```sh
echo "http://prometheus.$INGRESS_HOST"
```

* Open it in a browser

```sh
echo "http://grafana.$INGRESS_HOST"
```

* Open it in a browser
* Use `admin` as the user and `prom-operator` as the password
* Explore dashboards

```sh
hey -z 5m "http://cncf-demo.$INGRESS_HOST"
```

* See the results in Grafana dashboards

## Continue the Adventure

We'll continue the adventure soon. Until then, feel free to [destroy](../destroy/observability) what we created.
