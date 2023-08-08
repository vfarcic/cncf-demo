# Develop The Application With DevSpace And Kustomize

TODO: Intro

## Setup

```bash
chmod +x manuscript/develop/devspace-kustomize.sh

./manuscript/develop/devspace-kustomize.sh
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

* [Create and Manage a Production Kubernetes Cluster](../cluster/README.md)
