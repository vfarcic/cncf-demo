# Logging with Logging Operator and Fluentd

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/logging/logging-operator.sh

./manuscript/logging/logging-operator.sh
```

## Do

```sh
kubectl get loggings,fluentbitagents,outputs --all-namespaces

cat logging-operator/event-tailer.yaml

cp logging-operator/event-tailer.yaml infra/.

git add .

git commit -m "EventTailer"

git push

kubectl --namespace monitoring logs \
    --selector app.kubernetes.io/instance=default-event-tailer \
    | jq .
```

* If the output says `No resources found in monitoring namespace`, the `EventTailer` has not yet been deployed. Wait for a few moments and try again.

```sh
echo "http://grafana.$INGRESS_HOST"
```

* Open it in a browser
* Use `admin` as the user and `prom-operator` as the password
* Open `Explore`
* Choose `Loki` as the data source.
* Filter by `app_kubernetes_io_instance` set to `default-event-tailer`

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel ytt](carvel.md)
* **cdk8s** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
