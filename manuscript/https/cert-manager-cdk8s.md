# Use HTTPS With cert-manager And cdk8s

## Do

```bash
cd cdk8s

cat app.go

cat main.go

yq --inplace ".tls.enabled = true" app.yaml

cdk8s synth --output ../yaml/dev --validate 

cd ..

cat yaml/dev/cncf-demo.k8s.yaml

kubectl --namespace dev apply --filename yaml/dev

kubectl --namespace dev \
    get issuers,certificaterequests,certificates,orders,secrets

echo "https://cncf-demo-dev.$DOMAIN"

# Open it in a browser
```

## Continue The Adventure

* [Set Up PostgreSQL DB in the Dev Environment](../db/README.md)
