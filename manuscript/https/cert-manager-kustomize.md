# Use HTTPS With cert-manager And Kustomize

TODO: Intro

## Setup

```bash
yq --inplace \
    ".[].value = \"cncf-demo-dev.$DOMAIN\"" \
    kustomize/overlays/dev/ingress.yaml

yq --inplace \
    ".spec.commonName = \"cncf-demo-dev.$DOMAIN\"" \
    kustomize/overlays/dev/certificate.yaml

yq --inplace \
    ".spec.dnsNames[0] = \"cncf-demo-dev.$DOMAIN\"" \
    kustomize/overlays/dev/certificate.yaml
```

## Do

```bash
cat kustomize/base/ingress.yaml

yq --inplace \
    ".metadata.labels.\"cert-manager.io/cluster-issuer\" = \"production\"" \
    kustomize/base/ingress.yaml

cat kustomize/base/ingress.yaml

cat kustomize/overlays/dev/ingress.yaml

cat kustomize/overlays/dev/certificate.yaml

cat kustomize/overlays/dev/kustomization.yaml

yq --inplace \
    ".resources += \"certificate.yaml\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/kustomization.yaml

kubectl --namespace dev apply --kustomize kustomize/overlays/dev

kubectl --namespace dev \
    get issuers,certificaterequests,certificates,orders,secrets

echo "https://cncf-demo-dev.$DOMAIN"

# Open it in a browser
```

## Continue The Adventure

[Setup PostgreSQL DB](../db/README.md)
