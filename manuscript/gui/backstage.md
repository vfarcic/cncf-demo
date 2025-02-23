# Graphical User Interface (GUI) with Backstage

TODO: Intro

## Setup

> Watch [Nix for Everyone: Unleash Devbox for Simplified Development](https://youtu.be/WiFLtcBvGMU) if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

> Skip executing `devbox shell` if you are already inside the Shell from one of the previous episodes.

```bash
devbox shell

source .env
```

> Watch [The Future of Shells with Nushell! Shell + Data + Programming Language](https://youtu.be/zoX_S6d-XU4) if you are not familiar with Nushell. Alternatively, you can inspect the `dot.nu` script and transform the instructions in it to Bash or ZShell if you prefer not to use that Nushell script.

```sh
./dot.nu apply backstage "0.0.3" \
    --ingress_host "backstage.$INGRESS_HOST" \
    --github_token $GITHUB_TOKEN \
    --create_service_account true

source .env
```

## Do

> Observe the claims ingested from the cluster.
> `CREATE` a new claim.

## Continue The Adventure

* [Specialized Templating](../specialized-templates/README.md)
