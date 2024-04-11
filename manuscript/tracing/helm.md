# Tracing with Jaeger and Helm

TODO: Intro

## Do

```bash
# If Argo CD
yq --inplace \
    ".spec.source.helm.parameters[15].value = \"true\"" \
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
echo "http://cncf-demo.$INGRESS_HOST"
```

* Use the URL from the output to generate load with [Ddosify](https://ddosify.com) or any other way.

```sh
echo "http://jaeger.$INGRESS_HOST"
```

* Open the URL from the output in a browser

## Continue The Adventure

* [Logging](../logging/README.md)
