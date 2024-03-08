# Access Authorization With OpenFGA

TODO: Intro

## Setup

FIXME: Move to a script

```bash
# Execute only if using Argo CD
yq --inplace ".spec.source.helm.parameters[1].value = \"$INGRESS_CLASSNAME\"" \
    argocd/openfga.yaml

# Execute only if using Argo CD
yq --inplace ".spec.source.helm.parameters[2].value = \"openfga.$INGRESS_HOST\"" \
    argocd/openfga.yaml

# Execute only if using Flux
yq --inplace ".spec.values.ingress.className = \"$INGRESS_CLASSNAME\"" \
    flux/openfga-release.yaml

# Execute only if using Flux
yq --inplace ".spec.values.ingress.hosts[0].host = \"openfga.$INGRESS_HOST\"" \
    flux/openfga-release.yaml

cp $GITOPS_APP/openfga*.yaml infra/.

git add .

git commit -m "OpenFGA"

git push

COUNTER=$(kubectl --namespace openfga get pods)

while [ -z "$COUNTER" ]; do
    sleep 10
    COUNTER=$(kubectl --namespace openfga get pods)
done

export FGA_API_URL="http://openfga.$INGRESS_HOST"
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

## How Did You Define Your App?

* [Helm](openfga-helm.md)
* [Kustomize](openfga-kustomize.md)
* [Carvel ytt](openfga-carvel.md)
* **cdk8s** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
