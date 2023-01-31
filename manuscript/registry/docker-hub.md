# Store Container Image in a Registry with Docker Hub (Distribution)

TODO: Intro

## Setup

* Register in https://hub.docker.com/signup (if you haven't already).

```bash
export REGISTRY=index.docker.io

# Replace `[...]` with your Docker Hub username
export DOCKERHUB_USERNAME=[...]

export IMAGE=$REGISTRY/$DOCKERHUB_USERNAME/cncf-demo

yq --inplace ".image = \"$IMAGE\"" settings.yaml

# Make sure that Docker is running

docker login --username $DOCKERHUB_USERNAME $REGISTRY
```

## Do

```bash
echo $IMAGE

docker image tag cncf-demo:$TAG $IMAGE:$TAG

docker image tag cncf-demo:$TAG ${IMAGE}:latest

docker image push $IMAGE:$TAG

docker image push ${IMAGE}:latest

echo "https://hub.docker.com/r/$DOCKERHUB_USERNAME/cncf-demo"

# Open it in a browser
```

* `kbld` could have pushed images to the registry. Whether we'll do that or not depends on later choices.

## Continue The Adventure

[Define And Deploy The App To Dev](../define-deploy-dev/README.md)
