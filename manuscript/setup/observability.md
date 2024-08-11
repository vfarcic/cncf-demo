# Setup

You can skip the setup phase if you came to this chapter directly from the previous one.

> Watch https://youtu.be/BII6ZY2Rnlc if you are not familiar with GitHub CLI.
> You can skip the command that follows if you already forked the repo and merged it with upstream.

```bash
gh repo fork vfarcic/cncf-demo --clone --remote

cd cncf-demo

gh repo set-default

# Select the fork as the default repository
```

* If you already have the previous chapter up and running and the `vfarcic/cncf-demo` fork is merged with the upstream, you can skip the steps that execute the `observability.sh` script.

TODO: Add Flux

TODO: Add Carvel kapp-controller

TODO: Add ingress-nginx

TODO: Add Emissary-ingress

> Watch https://youtu.be/WiFLtcBvGMU if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

```bash
devbox shell

chmod +x manuscript/setup/observability.sh

./manuscript/setup/observability.sh

source .env
```

## Start The Chapter

* [Dashboards](../dashboards/README.md)