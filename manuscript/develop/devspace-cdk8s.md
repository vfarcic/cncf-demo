# Develop The Application With DevSpace And cdk8s

TODO: Intro

## Setup

* Install the [`devspace` CLI](https://devspace.sh/docs/getting-started/installation)

```bash
yq --inplace ".images.app.image = \"$IMAGE\"" devspace.yaml

yq --inplace \
    ".deployments.app.kubectl.manifests[0] = \"yaml/dev\"" \
    devspace.yaml

export RUN_COMMANDS="cd cdk8s
cdk8s synth --output ../yaml/dev --validate
cd ..
create_deployments --all
start_dev app"

yq --inplace ".pipelines.dev.run = \"$RUN_COMMANDS\"" \
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

The Adventure will continue soon...

[Destroy Everything](../destroy-all.md)
