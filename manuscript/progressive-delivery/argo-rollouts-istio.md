# Progressive Delivery with Argo Rollouts and Istio

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
# TODO: kapp-controller
```

* Execute `prometheus.sh` script only if you did NOT already install Prometheus.

```sh
chmod +x manuscript/metrics/prometheus.sh

./manuscript/metrics/prometheus.sh
```

* Execute `istio.sh` script only if you did NOT already install Istio

```sh
chmod +x manuscript/mtls/istio.sh

./manuscript/mtls/istio.sh

source .env

cat istio/namespace-production.yaml

cp istio/namespace-production.yaml apps/.

git add . 

git commit -m "Istio"

git push

kubectl get namespace production --output yaml
```

> Wait until the `istio-injection` label was added.

```sh
kubectl --namespace production delete pods \
    --selector app.kubernetes.io/name=cncf-demo

kubectl --namespace production get pods
```

> Confirm that two containers (main and sidecar) are in the cncf-demo Pod.

## Do

```sh
cat argo-rollouts/istio.yaml

cp argo-rollouts/istio.yaml infra/argo-rollouts-analysis.yaml

git add .

git commit -m "Analysis"

git push

kubectl get clusteranalysistemplates
```

* Wait until the resource was created

## How Did You Define Your App?

* [Kustomize](argo-rollouts-kustomize.md)
* **Helm** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Carvel ytt** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **cdk8s** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
