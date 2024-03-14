# Managing Secrets With External Secrets Operator (ESO) and Carvel ytt

TODO: Intro

## Do

```bash
kubectl --namespace production get secret cncf-demo-db-password \
    --output jsonpath="{.data.password}" | base64 --decode

cat yaml/prod/app.yaml

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
kubectl patch database.postgresql.sql.crossplane.io \
    cncf-demo-db-cncf-demo-db \
    --type merge --patch '{"metadata":{"finalizers":null}}'

yq --inplace ".db.insecure = false" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

cat yaml/prod/app.yaml

cp $GITOPS_APP/cncf-demo-ytt.yaml apps/cncf-demo.yaml

git add .

git commit -m "Switched to ESO"

git push

kubectl --namespace production \
    get externalsecrets.external-secrets.io

# Wait until the externalsecret is created

kubectl --namespace production get secret cncf-demo-db-password \
    --output jsonpath="{.data.password}" | base64 --decode
```

## Continue The Adventure

* [Secrets Management Outside Kubernetes](client.md)
