# Build Container Image With Lima In Dev Environments

TODO: Intro

## Setup

* [Install Rancher Desktop](https://docs.rancherdesktop.io/getting-started/installation)
* Go to Preferences > Container Engine and make sure that containerd is selected

## Do

```bash
alias docker=$(which nerdctl)

cat Dockerfile

export TAG=v0.0.1

docker image build --tag cncf-demo:$TAG .

docker image ls
```

## Continue The Adventure

[Store Container Image In A Registry](../registry/story.md)

