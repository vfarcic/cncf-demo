# Build Container Image With Lima In Dev Environments

[Rancher Desktop](https://docs.rancherdesktop.io/) is an application that provides container management and Kubernetes on the desktop. By default, Rancher Desktop provides a *single cluster with single node* setup. When we choose containerd as our container engine in the Rancher Desktop preferences, Rancher Desktop uses Lima to launch a Linux virtual machine that is optimized to run containerd and `nerdctl` (contaiNERD ctl).

With this image building stragety, `nerdctl` is building the image using [BuildKit](https://docs.docker.com/build/buildkit/), an improved build solution to replace Docker's legacy builder.

## Setup

* [Install Rancher Desktop](https://docs.rancherdesktop.io/getting-started/installation)
* Go to Preferences > Container Engine and make sure that containerd is selected

## Do

```bash
alias docker=$(which nerdctl)

cat Dockerfile

export TAG=v0.0.1

yq --inplace ".tag = \"$TAG\"" settings.yaml

docker image build --tag cncf-demo:$TAG .

docker image ls
```

## Continue The Adventure

* [Store Container Image in a Registry](../registry/README.md)
