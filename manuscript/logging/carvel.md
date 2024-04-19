# Logging with Logging Operator, Fluentd, and Carvel YTT

TODO: Intro

## Do

```bash
yq --inplace ".logging.enabled = true" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml | yq .

git add .

git commit -m "Loggign"

git push

kubectl --namespace production get logging-all
```

* Wait until resources are created

```sh
curl "http://cncf-demo.$INGRESS_HOST?something=else"
echo "http://grafana.$INGRESS_HOST"
```

* Open it in a browser
* Use `admin` as the user and `prom-operator` as the password
* Open `Explore`

## Continue The Adventure

The adventure will continue soon. Until then, please [destroy everything](../destroy/observability.md)
