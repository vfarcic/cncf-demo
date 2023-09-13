# Managing Secrets With External Secrets Operator (ESO) and cdk8s

TODO: Intro

## Do

```bash
kubectl --namespace production get secret cncf-demo-db-password \
    --output jsonpath="{.data.password}" | base64 --decode

cat yaml/prod/cncf-demo.k8s.yaml

# Instead of specifying the secret as `kind: Secret`,
# we could have specified it as `kind: ExternalSecret`.

# Now the secret is tied to Crossplane objects and we need to
#   remove it first.

rm apps/cncf-demo.yaml

git add .

git commit -m "Removed the app"

git push

kubectl get managed

# Wait until all the managed resources are deleted

yq --inplace ".db.insecure = false" cdk8s/app-prod.yaml

cd cdk8s

ENVIRONMENT=prod cdk8s synth --output ../yaml/prod --validate

cd ..

cat yaml/prod/cncf-demo.k8s.yaml

cp $GITOPS_APP/cncf-demo-cdk8s.yaml apps/cncf-demo.yaml

git add .

git commit -m "Switched to ESO"

git push

kubectl --namespace production \
    get externalsecrets.external-secrets.io

# TODO: Check why it fails in Azure

# Wait until the externalsecret is created

kubectl --namespace production get secret cncf-demo-password \
    --output jsonpath="{.data.password}" | base64 --decode
```

## Continue The Adventure

* [Mutual TLS](../mtls/README.md)
