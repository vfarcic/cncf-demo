# Setup

```bash
# Install `gum` by following the instructions in
#   https://github.com/charmbracelet/gum#installation
# Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with
#   Charm Gum.

# If you already have the previous chapter up and running and the
#   `vfarcic/cncf-demo` fork is merged with the upstream, you can
#   skip the steps that download and execute the `security.sh`
#   script.

curl -o security.sh \
    https://raw.githubusercontent.com/vfarcic/cncf-demo/main/manuscript/setup/security.sh

chmod +x security.sh

./security.sh

source .env
```

## Start The Chapter

* [Policies](../policies/README.md)