# Managing Secrets From AWS With External Secrets Operator (ESO)

## Do

```bash
kubectl --namespace production get secret cncf-demo-db-password \
    --output jsonpath="{.data.password}" | base64 --decode

cat yaml/prod/app.yaml

# Instead of specifying the secret as `kind: Secret`,
# we could have specified it as `kind: ExternalSecret`.

# Now the secret is tied to Crossplane objects and we need to
#   remove it first.

yq --inplace ".db.insecure = false" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml | yq .

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

## What Is Your Choice?

* [Istio](../mtls/kubecon-paris-istio.md)
* [Linkerd](../mtls/kubecon-paris-linkerd.md)
* [Cilium and SPIFFE](../mtls/kubecon-paris-cilium.md)

