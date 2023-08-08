# Setup PostgreSQL DB In The Dev Environment With Helm And cdk8s

TODO: Intro

## Setup

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo update
```

## Do

```bash
cd cdk8s

cat db.go

cat app.go

cat main.go

export ENVIRONMENT=dev

yq --inplace ".db.enabled.helm = true" app-dev.yaml

cdk8s synth --output ../yaml/dev --validate 

cd ..

cat yaml/dev/cncf-demo.k8s.yaml

kubectl --namespace dev apply --filename yaml/dev

curl "https://cncf-demo-dev.$DOMAIN/videos"

# Proceed further ONLY if the output contains
#   `relation "videos" does not exist`.
```

## Continue The Adventure

* [Manage DB Schema](../db-schema/README.md)
