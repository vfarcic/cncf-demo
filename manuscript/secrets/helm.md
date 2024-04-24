# Managing Secrets With External Secrets Operator (ESO) and Helm

TODO: Intro

## Do

```bash
kubectl --namespace production get secret cncf-demo-db-password \
    --output jsonpath="{.data.password}" | base64 --decode

cat helm/app/templates/postgresql-crossplane.yaml

# Instead of specifying the secret as `kind: Secret`,
# we could have specified it as `kind: ExternalSecret`.

# Now the secret is tied to Crossplane objects and we need to
#   remove it first.

rm apps/cncf-demo.yaml

git add .

git commit -m "Removed the app"

git push

kubectl get managed

# Wait until all the managed resources are deleted
#   (ignore `database`).

# Execute the command that follows only if `database` resource
#   was left "dangling".
kubectl patch \
    database.postgresql.sql.crossplane.io cncf-demo-db \
    --type merge --patch '{"metadata":{"finalizers":null}}'

cp $GITOPS_APP/cncf-demo-helm.yaml apps/cncf-demo.yaml

cat apps/cncf-demo.yaml

# If Argo CD
yq --inplace \
    ".spec.source.helm.valuesObject.db.insecure = false" \
    apps/cncf-demo.yaml

# If Flux
yq --inplace ".spec.values.db.insecure = true" \
    apps/cncf-demo.yaml

git add .

git commit -m "Switched to ESO"

git push

kubectl --namespace production get externalsecrets

# Wait until the externalsecret is created

kubectl --namespace production get secret cncf-demo-password \
    --output jsonpath="{.data.password}" | base64 --decode
```

## Continue The Adventure

* [Secrets Management Outside Kubernetes](client.md)
