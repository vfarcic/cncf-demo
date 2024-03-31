# Dashboard With Headlamp

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

TODO: Rewrite

```bash
kubectl apply --server-side \
    --kustomize github.com/prometheus-operator/kube-prometheus

INGRESS_CLASSNAME=$(yq ".ingress.classname" settings.yaml)

INGRESS_HOST=$(yq ".ingress.host" settings.yaml)

yq --inplace ".spec.ingressClassName = \"$INGRESS_CLASSNAME\"" \
    prometheus/prometheus-ingress.yaml

yq --inplace \
    ".spec.rules[0].host = \"prometheus.$INGRESS_HOST\"" \
    prometheus/prometheus-ingress.yaml

kubectl --namespace monitoring \
    port-forward svc/prometheus-k8s 9090

kubectl --namespace monitoring port-forward svc/grafana 3000
```

* Open [http://localhost:3000](http://localhost:3000) in a browser
* Log in with `admin` / `admin`

## Do

TODO:

* Open it in a browser

## Continue the Adventure

The adventure will continue soon. Until then, please [destroy everything](../destroy/observability.md)
