# Build Container Image With kbld In Dev Environments

TODO: Intro

## Setup

* [Install `kbld` CLI](https://carvel.dev/kbld/docs/v0.36.0/install)

```bash
TODO:
```

## Do

```bash
cat Dockerfile

cat kbld/deployment.yaml

kbld --file kbld/deployment.yaml | tee kbld/deployment-kbld.yaml

# Replace `[...]` with the image tag from the output
export TAG=[...]
```

* `kbld` can also push images to a registry. Whether we'll do that or not depends on later choices.

## Continue The Adventure

[Store Container Image In A Registry](../registry/story.md)
