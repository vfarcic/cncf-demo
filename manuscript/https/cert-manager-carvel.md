# Use HTTPS With cert-manager And Carvel ytt

## Do

```bash
cat ytt/resources/ingress.yaml

cat ytt/resources/certificate.yaml

cat ytt/schema.yaml

yq --inplace ".tls.enabled = true" ytt/schema.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-dev.yaml \
    | tee yaml/dev/app.yaml

kubectl --namespace dev apply --filename yaml/dev

kubectl --namespace dev \
    get issuers,certificaterequests,certificates,orders,secrets

echo "https://cncf-demo-dev.$DOMAIN"

# Open it in a browser
```

## Continue The Adventure

* [Set Up PostgreSQL DB in the Dev Environment](../db/README.md)
