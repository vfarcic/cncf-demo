# Dashboard With Headlamp

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

TODO: Rewrite

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

```sh
echo "http://cncf-demo.$INGRESS_HOST"

curl "http://cncf-demo.$INGRESS_HOST/videos"

curl -X POST "http://cncf-demo.$INGRESS_HOST/video?id=-qeoLfSGlFU&title=DevOps%20Tools%202024"

curl "http://cncf-demo.$INGRESS_HOST/videos" | jq .
```

## Continue the Adventure

The adventure will continue soon. Until then, please [destroy everything](../destroy/observability.md)
