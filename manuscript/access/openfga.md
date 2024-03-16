# Access Authorization With OpenFGA

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/access/openfga.sh

./manuscript/access/openfga.sh

source .env
```

* Install `fga` CLI by following the instructions at https://openfga.dev/docs/getting-started/install-sdk (the CLI tab).
* OpenFGA was installed with in-memory database and is publicly accessible through Ingress. A "real" DB should be used and the server should not be accessible.

## Do

```bash
curl "$FGA_API_URL/healthz"

export FGA_STORE_ID=$(fga store create --name "dot" \
    | jq -r .store.id)

fga store list

cat openfga/model.json

export FGA_MODEL_ID=$(fga model write --store-id $FGA_STORE_ID \
    --file openfga/model.json | jq -r .authorization_model_id)

echo $FGA_MODEL_ID

fga model list --store-id $FGA_STORE_ID

fga tuple write --store-id $FGA_STORE_ID \
    --model-id $FGA_MODEL_ID \
    user:vfarcic writer document:silly-demo

fga tuple write --store-id $FGA_STORE_ID \
    --model-id $FGA_MODEL_ID \
    user:vfarcic reader document:silly-demo

fga tuple write --store-id $FGA_STORE_ID \
    --model-id $FGA_MODEL_ID \
    user:sfarcic reader document:silly-demo

cat openfga.go

cat video.go
```

* What follows assumes that authentication is done with a different tool and that the requests we're sending are using authenticated users.

## How Did You Define Your App?

* [Helm](openfga-helm.md)
* [Kustomize](openfga-kustomize.md)
* [Carvel ytt](openfga-carvel.md)
* **cdk8s** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
