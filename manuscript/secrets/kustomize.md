# Managing Secrets From Google Cloud With External Secrets Operator (ESO) and Kustomize

TODO: Intro

## Do

```bash
kubectl --namespace production get secret cncf-demo-db-password \
    --output jsonpath="{.data.password}" | base64 --decode

# Instead of specifying the secret like this:
cat kustomize/overlays/prod/postgresql-crossplane-secret-$DESTINATION.yaml

# ...we could have specified it like:
cat kustomize/overlays/prod/postgresql-crossplane-password-$DESTINATION.yaml

# Now the secret is tied to Crossplane objects and we need to
#   remove them first.

rm apps/cncf-demo.yaml

git add .

git commit -m "Removed the app"

git push

kubectl get managed

# Wait until all the managed resources are deleted

yq --inplace \
    "del(.resources[] | select(. == \"postgresql-crossplane-secret-$DESTINATION.yaml\"))" \
    kustomize/overlays/prod/kustomization.yaml

cat kustomize/overlays/prod/postgresql-crossplane-password-$DESTINATION.yaml

yq --inplace \
    ".resources += \"postgresql-crossplane-password-$DESTINATION.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

cp $GITOPS_APP/cncf-demo-kustomize.yaml apps/cncf-demo.yaml

git add .

git commit -m "Switched to ESO"

git push

kubectl --namespace production get externalsecrets

# Wait until the externalsecret is created

kubectl --namespace production get secret cncf-demo-password \
    --output jsonpath="{.data.password}" | base64 --decode
```

## Continue The Adventure

* [Mutual TLS](../mtls/README.md)
