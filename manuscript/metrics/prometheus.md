# Metrics With Prometheus

TODO: Intro

## Setup

> Watch https://youtu.be/WiFLtcBvGMU if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

> Please skip executing `devbox shell` if you are already inside the Shell from one of the previous episodes.

```bash
devbox shell

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

* [Tracing](../tracing/README.md)
