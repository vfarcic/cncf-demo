# AWS Secrets Management Outside Kubernetes With Teller

TODO: Intro

## Setup

This section asssumes that you created a secret store and a secret by following the instructions in the [Managing Secrets From AWS With External Secrets Operator (ESO)](aws.md) section.

```bash
# Replace `[...]` with your access key ID`
export AWS_ACCESS_KEY_ID=[...]

# Replace `[...]` with your secret access key
export AWS_SECRET_ACCESS_KEY=[...]

export AWS_DEFAULT_REGION=us-east-1
```

## Do

```bash
cat teller/aws.yaml

teller env --config teller/aws.yaml

eval $(teller env --config teller/aws.yaml)

echo $PRODUCTION_POSTGRESQL
```

## Continue The Adventure

[Mutual TLS (mTLS) and Network Policies](../mtls/README.md)
