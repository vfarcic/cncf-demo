# Setup Prerequisites

*Go through this document ONLY if you did NOT follow the story from the start (if you jumped straight into this chapter).*

```bash
# Watch https://youtu.be/BII6ZY2Rnlc if you are not familiar with GitHub CLI
gh repo fork vfarcic/cncf-demo --clone --remote

cd cncf-demo

# Select the fork as the default repository
gh repo set-default

# Create a Kubernetes cluster.
# If you're using a local Kubernetes cluster
#   (e.g., Rancher Desktop, Minikube, etc.), make sure that it
#   has at least 8GB of RAM and 4 CPU of memory.

# Install `yq` CLI from https://github.com/mikefarah/yq
# 'yq' is a lightweight and portable command-line YAML processor
yq --inplace ".image = \"index.docker.io/vfarcic/cncf-demo\"" \
    settings.yaml

yq --inplace ".tag = \"v0.0.1\"" settings.yaml

# Execute this step ONLY if you chose to use `nip.io` instead of
#   a "real" domain
alias curl="curl --insecure"
```

## Start The Chapter

* [Create And Manage Production Kubernetes Cluster](../cluster/README.md)