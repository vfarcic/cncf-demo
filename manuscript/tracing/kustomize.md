# Tracing with Jaeger and Kustomize

TODO: Intro

## Do

```bash
yq --inplace \
    ".patchesStrategicMerge += \"deployment-otel.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

git add .

git commit -m "Switched to ESO"

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
