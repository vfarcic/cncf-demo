# Tracing with Jaeger and Helm

TODO: Intro

## Do

```bash
# If Argo CD
yq --inplace \
    ".spec.source.helm.valuesObject.otel.enabled = true" \
    apps/cncf-demo.yaml

# If Flux
yq --inplace ".spec.values.otel.enabled = true" \
    apps/cncf-demo.yaml

git add .

git commit -m "Instrumentation"

git push

kubectl --namespace production get pods
```

* Wait until `cncf-demo` Pod (NOT cncf-demo-controller-0) has two containers

```sh
hey -z 5m "http://cncf-demo.$INGRESS_HOST"

echo "http://jaeger.$INGRESS_HOST"
```

* Open the URL from the output in a browser

## Continue The Adventure

* [Progressive Delivery](../progressive-delivery/README.md)
