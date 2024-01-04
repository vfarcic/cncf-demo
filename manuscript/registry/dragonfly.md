# Store Container Image in a Registry with Dragonfly

Dragonfly is a file distribution system based on peer-to-peer (P2P) networking.

### What is peer-to-peer networking?

In contrast to conventional client-server network systems, with P2P networking all of the computers are connected to one another, and also through a single server computer. The role of the server is usually to help the computers ("peers") find one another. After the peers are found, they communicate directly - the traffic between the peers will not pass through the main server. Regarding sharing information within the network, each device serves the purpose of both the server and the client. Each peer plays an independent role, and has access to save the entire set of shared data in its own database. This enables the speedy transfer of files to and from anywhere in the system.

### Nydus

Dragonfly additionally has a sub-project called [Nydus](https://nydus.dev/) that is an open source filesystem solution that aids in high-efficiency image distribution.

The Dragonfly/Nydus combo is powerful. 

First because **Nydus-formatted images are made up of smaller pieces that can be moved around independently of one another.** This combined with using Dragonfly's P2P network can take advantage of every node's bandwidth, greatly reducing image pull time.

Second because **Nydus knows which part of the image is essential for the start-up of the container** - maybe only 50 MB of data of a 1 GB image - **and it will begin by just pulling that part so the container can be started.** In this way it greatly reduces the container startup time. This is also good for serverless scenerios.  

It is important to note here that the Nydus image format is different from the OCI image format - in order to take advantage of the benefits of Nydus, your OCI images will need to be converted to Nydus images. However the Nydus ecosystem has a number of tools to help with the conversion, such as [a CLI tool](https://github.com/dragonflyoss/image-service/blob/master/docs/nydusify.md), a [Harbor acceleration service](https://github.com/goharbor/acceleration-service), and [Buildkit](https://github.com/moby/buildkit/issues/2046) provides the ability to build and export Nydus images directly from a Dockerfile.

## Setup

* Make sure that Docker is running

```bash
# We're using Dragonfly with Docker Hub but it also works well with Harbor
export REGISTRY=index.docker.io

# Replace `[...]` with your Docker Hub username
export DOCKERHUB_USERNAME=[...]

# Tag your container image with the registry location
export IMAGE=$REGISTRY/$DOCKERHUB_USERNAME/cncf-demo

docker login --username $DOCKERHUB_USERNAME $REGISTRY

# Change the permissions of this script
chmod +x manuscript/registry/dragonfly.sh

# Run the script. This does the following:
# 1. Adds an “image” entry to settings.yaml and saves your image name for future use
# 2. Creates a “values.yaml” file and adds the config that Dragonfly needs to use Docker Hub as the underlying image registry
# 3. Installs Dragonfly using Helm
./manuscript/registry/dragonfly.sh
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

# Pull image through dragonfly.
docker image pull ${IMAGE}:$TAG

# Pull image through dragonfly.
docker image pull ${IMAGE}:latest
```

## Continue The Adventure

* [Define And Deploy The App To Dev](../define-deploy-dev/README.md)
