# Build Container Image With kbld In Dev Environments

kbld is a CLI that automates image building, image pushing, and deployment configuration updates. kbld does this in four steps:

1. finds image references in your deployment configuration (using image keys)
2. builds images from the referenced source code (specified in a kbld config definition)
3. puts the images in a registry (optional)
4. records the resulting image references in a yaml file

kbld will automatically give each image a unique tag, which is useful since we are not yet pushing to a remote registry. As soon as images are pushed to a remote registry, tags are converted into digest references. 

Fun fact: kbld can work with multiple changing applications simultaneously, which is especially useful during local development.

## Setup

* [Install `kbld` CLI](https://carvel.dev/kbld/docs/v0.36.0/install)

```bash
TODO:
```

## Do

```bash

# should we use docker or CNBs?
cat Dockerfile

cat kbld/deployment.yaml

kbld --file kbld/deployment.yaml | tee kbld/deployment-kbld.yaml

# Replace `[...]` with the image tag from the output
export TAG=[...]
```

* `kbld` can also push images to a registry. Whether we'll do that or not depends on later choices.
* `kbld` can also find and update image references within your configuration. Whether we'll do that or not depends on later choices.

## Continue The Adventure

[Store Container Image In A Registry](../registry/story.md)
