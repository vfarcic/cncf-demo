# Metrics With Pixie

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

TODO: Rewrite

```bash
chmod +x manuscript/metrics/pixie.sh

./manuscript/metrics/pixie.sh
```

## Do

* Open https://work.withpixie.ai in a browser

```sh
px scripts list

px scripts run px/namespaces

px scripts run px/namespace -- --help

px scripts run px/namespace -- --namespace production

px scripts show px/namespace

px live px/namespaces

# Press `Ctrl+c` to stop it

px live px/namespace -- --namespace production

# Press `Ctrl+c` to stop it
```

## Continue the Adventure

* [Tracing](../tracing/README.md)
