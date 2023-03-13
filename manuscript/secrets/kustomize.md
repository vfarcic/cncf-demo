# Managing Secrets From Google Cloud With External Secrets Operator (ESO) and Kustomize

TODO: Intro

## Do

TODO: Remove the secret from Kustomize
TODO: Confirm that the secret is removed
TODO: Apply the secret with ESO

```bash
kubectl --namespace production get secret cncf-demo-password \
    --output jsonpath="{.data.password}" | base64 --decode

cat kustomize/overlays/prod/postgresql-crossplane-secret-$DESTINATION.yaml

yq --inplace \
    "del(.resources[] | select(. == \"postgresql-crossplane-secret-$DESTINATION.yaml\"))" \
    kustomize/overlays/prod/kustomization.yaml

cat kustomize/overlays/prod/postgresql-crossplane-password-$DESTINATION.yaml

yq --inplace ".resources += \"postgresql-crossplane-password-$DESTINATION.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

git add .

git commit -m "Switched to ESO"

git push

kubectl --namespace production get externalsecrets

# Wait until the externalsecret is created

kubectl --namespace production get secret cncf-demo-password \
    --output jsonpath="{.data.password}" | base64 --decode
```

## Continue The Adventure

[Mutual TLS](../mtls/README.md)
