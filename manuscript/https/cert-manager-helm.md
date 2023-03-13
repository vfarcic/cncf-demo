# Use HTTPS With cert-manager And Helm

## Do

```bash
cat helm/app/templates/ingress.yaml

cat helm/app/templates/certificate.yaml

cat helm/app/values.yaml

yq --inplace ".tls.enabled = true" helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait

kubectl --namespace dev \
    get issuers,certificaterequests,certificates,orders,secrets

echo "https://cncf-demo-dev.$DOMAIN"

# Open it in a browser
```

## Continue The Adventure

[Set Up PostgreSQL DB in the Dev Environment](../db/README.md)
