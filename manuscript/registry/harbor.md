# Store Container Image in a Registry with Harbor

Harbor is a CNCF-Graduated, open source container image registry. It has three main features:

1. secures artificts with policies and role-based access control
2. ensures that container images are scanned and free from vulnerablities
3. signs images as trusted

Harbor can be installed in any Kubernetes environment or on a system with Docker support.

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

helm repo add harbor https://helm.goharbor.io

helm repo update

helm upgrade --install harbor harbor/harbor \
    --namespace harbor --create-namespace \
    --values harbor/values.yaml --wait

kubectl --namespace harbor apply \
    --filename harbor/certificate.yaml

kubectl --namespace harbor get pods

# Wait for a while for all the Pods (except jobservice) to be
#   ready.

export REGISTRY=harbor.$DOMAIN

export IMAGE=$REGISTRY/library/cncf-demo

yq --inplace ".image = \"$IMAGE\"" settings.yaml

# Make sure that Docker is running

docker login --username admin $REGISTRY

# Password: Harbor12345
```

## Do

```bash
echo $IMAGE

docker image tag cncf-demo:$TAG $IMAGE:$TAG

docker image tag cncf-demo:$TAG $IMAGE:latest

docker image push $IMAGE:$TAG

docker image push $IMAGE:latest

echo "https://harbor.$DOMAIN"

# Open it in a browser

# User: admin
# Password: Harbor12345
```

* `kbld` could have pushed images to the registry. Whether we'll do that or not depends on later choices.

## Continue The Adventure

[Define And Deploy The App To Dev](../define-deploy-dev/README.md)
