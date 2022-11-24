# Use HTTPS With cert-manager And Helm

TODO: Intro

## Do

```bash
cat helm/app/templates/ingress.yaml

cat helm/app/templates/certificate.yaml

cat helm/app/values.yaml

yq --inplace ".tls.enabled = true" helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait

kubectl --namespace dev get certificates

echo "https://dev.cncf-demo.$DOMAIN"

# Open it in a browser
```

## Continue The Adventure

[Setup PostgreSQL DB](../db/story.md)

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
yq --inplace ".tls.enabled = false" helm/app/values.yaml

helm upgrade --install cncf-demo helm --namespace dev --wait
```
