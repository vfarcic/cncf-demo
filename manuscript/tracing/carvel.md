# Access Authorization With OpenFGA and Carvel ytt

TODO: Intro

## Do

```bash
yq --inplace ".otel.enabled = true" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml | yq .

git add .

git commit -m "Switched to ESO"

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

The adventure will continue soon. Until then, please [destroy everything](../destroy/observability.md)
