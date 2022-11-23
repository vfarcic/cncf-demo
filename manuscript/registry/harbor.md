# Store Container Image In A Registry With Harbor

TODO: Intro

## Setup

```bash
yq --inplace \
    ".spec.commonName = \"harbor.$DOMAIN\"" \
    harbor/certificate.yaml

yq --inplace \
    ".spec.dnsNames[0] = \"harbor.$DOMAIN\"" \
    harbor/certificate.yaml

yq --inplace \
    ".expose.ingress.hosts.core = \"harbor.$DOMAIN\"" \
    harbor/values.yaml

yq --inplace \
    ".expose.ingress.hosts.notary = \"notary.$DOMAIN\"" \
    harbor/values.yaml

yq --inplace \
    ".externalURL = \"https://harbor.$DOMAIN\"" \
    harbor/values.yaml

kubectl create namespace harbor

kubectl --namespace harbor apply \
    --filename harbor/certificate.yaml

helm repo add harbor https://helm.goharbor.io

helm repo update

helm upgrade --install harbor harbor/harbor \
    --namespace harbor \
    --values harbor/values.yaml

export REGISTRY=harbor.$DOMAIN

export IMAGE=$REGISTRY/library/cncf-demo

# Make sure that Docker is running

docker login --username admin $REGISTRY

# Password: Harbor12345
```

## Do

```bash
echo $IMAGE

docker image tag cncf-demo:v0.0.1 $IMAGE:v0.0.1

docker image push $IMAGE:v0.0.1

echo "https://harbor.$DOMAIN"

# Open it in a browser

# User: admin
# Password: Harbor12345
```

## Continue The Adventure

[Define And Deploy The App To Dev](../define-deploy-dev/story.md)