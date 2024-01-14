# Develop The Application With Devfile And odo

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum

```bash
chmod +x manuscript/develop/devfile.sh

./manuscript/develop/devfile.sh
```

## Do

```bash
odo init

odo preference set Ephemeral true

odo set namespace dev

odo dev

# Open http://localhost:20001 in a browser

# Open a second terminal and navigate to the project root

# In the second terminal
# Open `root.go` and modify the output however you like

# In the second terminal
exit

# Refresh the browser tab

# Press `Ctrl+c` in the first terminal to stop development and clean up the resources
```

## Continue The Adventure

* [Create and Manage a Production Kubernetes Cluster](../cluster/README.md)
