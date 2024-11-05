# Observability with Networking and Istio

TODO: Intro

## Setup

> Watch https://youtu.be/WiFLtcBvGMU if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

> Please skip executing `devbox shell` if you are already inside the Shell from one of the previous episodes.

```sh
devbox shell
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

kubectl get namespace production --output yaml
```

> Wait until the `istio-injection` label was added.

```sh
kubectl --namespace production delete pods \
    --selector app.kubernetes.io/name=cncf-demo

kubectl --namespace production get pods
```

> Confirm that three containers (main and two sidecars) are in the cncf-demo Pod. 

## Do

```sh
echo "http://prometheus.$INGRESS_HOST"
```

> Open the URL from the output in a browser.

```sh
istioctl dashboard kiali
```

## How Did You Define Your App?

* [Kustomize](istio-kustomize.md)
* **Helm** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* [Carvel ytt](istio-carvel.md)
* **cdk8s** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
