# Tracing with Jaeger and cdk8s

TODO: Intro

## Do

```bash
cd cdk8s

export ENVIRONMENT=prod

yq --inplace ".otel.enabled = true" app-prod.yaml

cdk8s synth --output ../yaml/prod --validate 

cd ..

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
