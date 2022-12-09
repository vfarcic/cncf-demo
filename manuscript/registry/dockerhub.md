# Store Container Image in a Registry with Docker Hub

TODO: Intro

## Setup

* Register in https://hub.docker.com/signup (if you haven't already).

```bash
export REGISTRY=index.docker.io

# Replace `[...]` with your Docker Hub username
export DH_USER=[...]

export IMAGE=$REGISTRY/$DH_USER/cncf-demo

# Make sure that Docker is running

docker login --username $DH_USER $REGISTRY
```

## Do

```bash
echo $IMAGE

docker image tag cncf-demo:$TAG $IMAGE:$TAG

docker image push $IMAGE:$TAG

echo "https://hub.docker.com/r/$DH_USER/cncf-demo"

# Open it in a browser
```

* `kbld` could have pushed images to the registry. Whether we'll do that or not depends on later choices.

## Continue The Adventure

[Define And Deploy The App To Dev](../define-deploy-dev/story.md)
