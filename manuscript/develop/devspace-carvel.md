# Develop The Application With DevSpace And Carvel ytt

TODO: Intro

## Setup

* Install the [`devspace` CLI](https://devspace.sh/docs/getting-started/installation)

```bash
chmod +x manuscript/develop/devspace-carvel.sh

./manuscript/develop/devspace-carvel.sh
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
