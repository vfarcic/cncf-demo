# Store Container Image in a Registry with Docker Hub (Distribution)

Wait, is Docker Hub a CNCF project?

Technically no, but [Distribution](https://github.com/distribution) is. Distribution is the open source code that is the basis of the container registry that is part of Docker Hub. 

Distribution is a core library for many other registries too, including GitHub Container Registry, GitLab Container Registry, DigitalOcean Container Registry, and You Choose competitor [Harbor](../registry/harbor.md). 

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/registry/docker-hub.sh

./manuscript/registry/docker-hub.sh

source .env
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
