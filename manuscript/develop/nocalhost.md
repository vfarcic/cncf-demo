# Develop The Application With Telepresence

TODO: Intro

## Setup

* Install [Visual Studio Code](https://code.visualstudio.com/download)
* Install the `Nocalhost` extension in VSCode
* Install the `Open Browser Preview` extension in VSCode

## Do

```bash
code .

# Open the `Nocalhost` extension in VSCode
# Change the Kube Config value to `kubeconfig-dev.yaml` in the
#   project directory
# Set `dev`
# Click the `Add Cluster` button
# Open `dev` > `default` > `Workloads` > `Deployments`
# Click the hammer icon next to `cncf-demo`
# Click the `Open associated directory` button, select the
#   project directory and click the `Open` button
# Select `Custom` as the development image and type `golang:1.19`

# In the Nocalhost terminal
curl -sSfL \
    https://raw.githubusercontent.com/cosmtrek/air/master/install.sh \
    | sh -s -- -b /go/bin

# In the Nocalhost terminal
air

# In a Shell terminal
echo "https://cncf-demo-dev.$DOMAIN"

# Open it in a browser

# Open `root.go` and change the `This is a silly demo` message

# Refresh the browser

# In the Nocalhost terminal
# Press `ctrl+c`

# Click the hammer icon next to `silly-demo`
```

## Continue The Adventure

* [Create and Manage a Production Kubernetes Cluster](../cluster/README.md)
