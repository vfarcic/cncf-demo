# Store Container Image in a Registry with Harbor

Harbor is a CNCF-Graduated, open source container image registry. It has three main features:

1. secures artificts with policies and role-based access control
2. ensures that container images are scanned and free from vulnerablities
3. signs images as trusted

Harbor can be installed in any Kubernetes environment or on a system with Docker support.

## Setup

```bash
# Make sure that Docker is running

export REGISTRY=harbor.$DOMAIN

export IMAGE=$REGISTRY/library/cncf-demo

chmod +x manuscript/registry/harbor.sh

./manuscript/registry/harbor.sh
```

## Do

```bash
echo $IMAGE

docker image tag cncf-demo:$TAG $IMAGE:$TAG

docker image tag cncf-demo:$TAG ${IMAGE}:latest

docker image push $IMAGE:$TAG

docker image push ${IMAGE}:latest

echo "https://harbor.$DOMAIN"

# Open it in a browser

# User: admin
# Password: Harbor12345
```

* `kbld` could have pushed images to the registry. Whether we'll do that or not depends on later choices.

## Continue The Adventure

* [Define And Deploy The App To Dev](../define-deploy-dev/README.md)
