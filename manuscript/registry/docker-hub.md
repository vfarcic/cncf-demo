# Store Container Image in a Registry with Docker Hub (Distribution)

Wait, is Docker Hub a CNCF project?

Technically no, but [Distribution](https://github.com/distribution) is. Distribution is the open source code that is the basis of the container registry that is part of Docker Hub. 

Distribution is a core library for many other registries too, including GitHub Container Registry, GitLab Container Registry, DigitalOcean Container Registry, and You Choose competitor [Harbor](../registry/harbor.md). 

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Charm Gum provides utilities to help you write useful shell scripts with just a few lines of code. Watch https://youtu.be/U8zCHA-9VLA to learn more.

```bash
chmod +x manuscript/registry/docker-hub.sh

# This shell script collects your Docker username and password, sets variables, saves export commands for DOCKERHUB_USERNAME & IMAGE environment variables to a fresh .env file, and logs you in to Docker.
./manuscript/registry/docker-hub.sh

# Execute the commands in your .env file, which are simply setting DOCKERHUB_USERNAME & IMAGE environment variables to use in the next section.
source .env
```

## Do

```bash
echo $IMAGE

# Tag the local image "cncf-demo:$TAG" to point at the registry and have the full sha-256 tag
docker image tag cncf-demo:$TAG ${IMAGE}:$TAG

# Tag the local image "cncf-demo:$TAG" to point at the registry with the "latest" tag
docker image tag cncf-demo:$TAG ${IMAGE}:latest

# Push the two images to Docker Hub
docker image push ${IMAGE}:$TAG

docker image push ${IMAGE}:latest

# Generate your Docker Hub url
echo "https://hub.docker.com/r/$DOCKERHUB_USERNAME/cncf-demo"

# Open it in a browser
```

* `kbld` could have pushed images to the registry. Whether we'll do that or not depends on later choices.

## Continue The Adventure

* [Define And Deploy The App To Dev](../define-deploy-dev/README.md)
