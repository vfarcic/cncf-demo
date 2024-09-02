# Build Container Image With Cloud Native Buildpacks (CNB)

The [Cloud Native Buildpacks](https://buildpacks.io/) project takes source code as input and then outputs an [Open Container Initiative](https://opencontainers.org/) (OCI)-compliant container image. Cloud Native Buildpacks provide a dead-simple developer experience while giving platform teams the ability to control and regulate how images are built. 

There are many ways to implement Cloud Native Buildpacks. Here we will use the `pack` CLI which is maintained by the Cloud Native Buildpacks project.  

## Setup

* [Install the `pack` CLI](https://buildpacks.io/docs/tools/pack/#pack-cli)
* Make sure that Docker is up and running

## Do

```bash
export TAG=v0.0.1

yq --inplace ".tag = \"v0.0.1\"" settings.yaml

pack config default-builder paketobuildpacks/builder-jammy-tiny

pack build cncf-demo:$TAG

docker image ls
```

## Continue The Adventure

* [Store Container Image in a Registry](../registry/README.md)
