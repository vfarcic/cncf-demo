# Use HTTPS With cert-manager And Kustomize

TODO: Intro

## Setup

```bash
yq --inplace \
    ".[].value = \"dev.cncf-demo.$DOMAIN\"" \
    kustomize/overlays/dev/ingress.yaml
```

## Do

```bash
cat kustomize/base/ingress.yaml

yq --inplace \
    ".metadata.labels.\"cert-manager.io/cluster-issuer\" = \"production\"" \
    kustomize/base/ingress.yaml

cat kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/ingress.yaml

echo "---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: cncf-demo
spec:
  secretName: cncf-demo
  issuerRef:
    kind: ClusterIssuer
    name: production
  commonName: dev.cncf-demo.$DOMAIN
  dnsNames:
    - dev.cncf-demo.$DOMAIN
" | tee kustomize/overlays/dev/certificate.yaml

yq --inplace \
    ".resources += \"certificate.yaml\"" \
    kustomize/overlays/dev/kustomization.yaml

kubectl apply --kustomize kustomize/overlays/dev

kubectl --namespace dev \
    get issuers,certificaterequests,certificates,orders,secrets

echo "https://dev.cncf-demo.$DOMAIN"

# Open it in a browser
```

## Continue The Adventure

[Setup PostgreSQL DB](../db/story.md)

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
yq --inplace \
    "del(.metadata.labels.\"cert-manager.io/cluster-issuer\")" \
    kustomize/base/ingress.yaml

rm kustomize/overlays/dev/certificate.yaml

yq --inplace \
    "del(.resources[] | select(. == \"certificate.yaml\"))" \
    kustomize/overlays/dev/kustomization.yaml

kubectl --namespace dev delete certificate cncf-demo    

kubectl --namespace dev apply --kustomize kustomize/overlays/dev
```
