# Use HTTPS With cert-manager And Helm

## Do

```bash

# Notice that some values and actions only happens if TLS is enabled
cat helm/app/templates/ingress.yaml

# The first line states that this Certificate yaml only gets applied if TLS is enabled
cat helm/app/templates/certificate.yaml

# See that `.tls.enabled` is currently set to false
cat helm/app/values.yaml

# Enable TLS by setting `.tls.enabled` to be true!
yq --inplace ".tls.enabled = true" helm/app/values.yaml

# Redeploy our application for the changes to take effect
helm upgrade --install cncf-demo helm/app --namespace dev --wait

# See the resources that got created
kubectl --namespace dev \
    get issuers,certificaterequests,certificates,orders,secrets

# Generate a secure url
echo "https://cncf-demo-dev.$DOMAIN"

# Open it in a browser. Behold! Our secure application!
```

## Continue The Adventure

* [Set Up PostgreSQL DB in the Dev Environment](../db/README.md)
