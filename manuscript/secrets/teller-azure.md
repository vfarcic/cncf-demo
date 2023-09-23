# Azure Secrets Management Outside Kubernetes With Teller

TODO: Intro

## Setup

```bash
export KVAULT_NAME=$(\
    yq ".production.azure.keyvault" settings.yaml)

export AZURE_CLI=1
```

## Do

```bash
cat teller/azure.yaml

teller env --config teller/azure.yaml

teller sh --config teller/azure.yaml
```

## Continue The Adventure

* [Mutual TLS (mTLS) And Network Policies](../mtls/README.md)