# API (CRDs) & State Management (Controllers) Setup

> Watch https://youtu.be/BII6ZY2Rnlc if you are not familiar with GitHub CLI.
> You can skip the command that follows if you already forked the repo and merged it with upstream.

```bash
gh repo fork vfarcic/cncf-demo --clone --remote

cd cncf-demo

gh repo set-default
```

> Select the fork as the default repository

> Watch [Nix for Everyone: Unleash Devbox for Simplified Development](https://youtu.be/WiFLtcBvGMU) if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

```bash
devbox shell
```

> Watch [The Future of Shells with Nushell! Shell + Data + Programming Language](https://youtu.be/zoX_S6d-XU4) if you are not familiar with Nushell. Alternatively, you can inspect the `dot.nu` script and transform the instructions in it to Bash or ZShell if you prefer not to use that Nushell script.

```sh
chmod +x dot.nu

./dot.nu setup idp

source .env
```

## Start The Chapter

* [API (CRDs) & State Management (Controllers)](../api/README.md)