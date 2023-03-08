# Managing Secrets From Google Cloud With External Secrets Operator (ESO) and Kustomize

TODO: Intro

## Setup

```bash
export DESTINATION=$(yq ".crossplane.destination" \
    settings.yaml)
```

## Do

TODO: Remove the secret from Kustomize
TODO: Confirm that the secret is removed
TODO: Apply the secret with ESO

```bash
cat kustomize/overlays/prod/kustomization.postgresql-crossplane-secret-google.yaml

yq --inplace ".resources += \"postgresql-crossplane-$XP_DESTINATION.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml
```

## Continue The Adventure

[TODO:](TODO:)
