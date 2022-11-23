# Use HTTPS With cert-manager And Helm

TODO: Intro

## Setup

```bash
TODO:
```

## Do

```bash
cat helm/values.yaml

cat helm/templates/ingress.yaml

cat helm/templates/certificate.yaml

yq --inplace ".tls.enabled = true" helm/values.yaml

helm upgrade --install cncf-demo helm --namespace dev --wait

kubectl --namespace dev \
    get issuers,certificaterequests,certificates,orders,secrets

echo "https://dev.cncf-demo.$DOMAIN"

# Open it in a browser
```

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
yq --inplace ".tls.enabled = false" helm/values.yaml

helm upgrade --install cncf-demo helm --namespace dev --wait
```

## Continue The Adventure

[Setup PostgreSQL DB](../db/story.md)
