# Develop The Application With DevSpace And Kustomize

TODO: Intro

At the time of this writing (December 2022), DevSpace is not a CNCF project. However, it announced that it [started the process](https://thenewstack.io/?p=22695066) of joining the foundation so we're including it in the story.

## Setup

```bash
yq --inplace \
    ".deployments.app.kubectl.manifests[0] = \"kustomize/overlays/dev\"" \
    devspace.yaml

yq --inplace \
    ".deployments.app.kubectl.kustomize = true" \
    devspace.yaml
```

## Do

```bash
cat devspace.yaml

devspace dev --namespace dev

go run .

# Open a second terminal and navigate to the project root

# In the second terminal
# Open `root.go` and modify the output however you like

# In the first terminal
# `ctrl+c`

# In the first terminal
go run .

# Refresh the browser tab

# In the first terminal
# `ctrl+c`

# In the first terminal
exit

# In the second terminal
exit

devspace purge --namespace dev
```

## Continue The Adventure

[Create And Manage Production Kubernetes Cluster](../cluster/README.md)
[Destroy Everything](../destroy-all.md)
