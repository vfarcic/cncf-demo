# Scanning With Kubescape

TODO: Intro

## Setup

```bash
curl -s \
    https://raw.githubusercontent.com/kubescape/kubescape/master/install.sh \
    | /bin/bash

sudo mv ~/.kubescape/bin/kubescape /usr/local/bin/.
```

## Do

```bash
kubescape scan

kubescape scan framework mitre

kubescape scan image \
    index.docker.io/vfarcic/cncf-demo:v0.0.1

kubescape scan workload deployment/cncf-demo \
    --namespace production
```

## Continue The Adventure

* [Artifact Signing](../signing/README.md)
