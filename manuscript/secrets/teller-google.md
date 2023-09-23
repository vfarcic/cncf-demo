# Google Cloud Secrets Management Outside Kubernetes With Teller

TODO: Intro

## Setup

This section asssumes that you created a secret store and a secret by following the instructions in the [Managing Secrets From Google Cloud With External Secrets Operator (ESO)](google.md) section.

```bash
export PROJECT_ID=$(\
    yq ".production.google.projectId" settings.yaml)

yq --inplace \
    ".providers.google_secretmanager.env.PRODUCTION_POSTGRESQL.path = \"projects/$PROJECT_ID/secrets/production-postgresql/versions/1\"" \
    teller/google.yaml
```

## Do

```bash
cat teller/google.yaml

teller env --config teller/google.yaml

teller sh --config teller/google.yaml
```

## Continue The Adventure

* [Mutual TLS (mTLS) And Network Policies](../mtls/README.md)