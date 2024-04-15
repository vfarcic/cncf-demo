# Logging with Logging Operator (and Fluentd)

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
# Skip this command if you already installed Prometheus with Grafana
chmod +x manuscript/metrics/prometheus.sh

# Skip this command if you already installed Prometheus with Grafana
./manuscript/metrics/prometheus.sh

chmod +x manuscript/logging/logging-operator.sh

./manuscript/logging/logging-operator.sh
```

## Do

```sh
kubectl get loggings,fluentbitagents,outputs --all-namespaces
```

FIXME: Rewrite


```sh
kubectl --namespace a-team apply --filename flow.yaml

kubectl --namespace a-team get logging-all

curl "http://silly-demo.$INGRESS_HOST.nip.io/videos"

kubectl --namespace logging logs \
    svc/logging-operator-test-receiver
```

FIXME: Show in Grafana

```sh
cat event-tailer.yaml

kubectl --namespace logging apply --filename event-tailer.yaml

kubectl --namespace logging logs \
    --selector app.kubernetes.io/instance=default-event-tailer \
    | jq .

kubectl --namespace a-team delete --filename app/
```

```sh
echo "http://grafana.$INGRESS_HOST"
```

* Open it in a browser
* Use `admin` as the user and `prom-operator` as the password

## How Did You Define Your App?

* **Helm** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Kustomize** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Carvel ytt** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **cdk8s** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.

FIXME: Remove

## Continue The Adventure

The adventure will continue soon. Until then, please [destroy everything](../destroy/observability.md)
