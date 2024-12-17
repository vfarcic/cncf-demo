# Inspektor Gadget

TODO: Intro

## Setup

> Watch https://youtu.be/WiFLtcBvGMU if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

> Please skip executing `devbox shell` if you are already inside the Shell from one of the previous episodes.

```bash
devbox shell

kubectl gadget deploy
```

## Do

```sh
kubectl gadget --help

kubectl gadget trace --help

kubectl gadget advise network-policy monitor \
    --namespace production --output network.json &

curl "http://cncf-demo.$INGRESS_HOST"

pkill kubectl

cat network.json | jq .

kubectl gadget advise network-policy report --input network.json

kubectl gadget snapshot process --namespace production

kubectl gadget top ebpf

kubectl --namespace production run never-do-this --image alpine \
    -- /bin/sh -c \
    "apk add -U git && git clone https://github.com/torvalds/linux"

kubectl gadget top file --namespace production
```

## Continue the Adventure

* [Destroy everything](../destroy/observability.md) before starting a new chapter [API (CRDs) & State Management (Controllers)](../setup/idp.md)
