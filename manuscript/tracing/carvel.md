# Tracing with Jaeger and Carvel ytt

TODO: Intro

## Do

```bash
yq --inplace ".otel.enabled = true" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml | yq .

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

* [Data Pipelines](../data-pipelines/README.md)
