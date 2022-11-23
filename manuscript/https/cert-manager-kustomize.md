# Use HTTPS With cert-manager And Kustomize

TODO: Intro

## Setup

```bash
yq --inplace \
    ".spec.rules[0].host = \"dev.cncf-demo.$DOMAIN\"" \
    kustomize/overlays/cert-manager/ingress.yaml

yq --inplace \
    ".spec.tls[0].hosts[0] = \"dev.cncf-demo.$DOMAIN\"" \
    kustomize/overlays/cert-manager/ingress.yaml

yq --inplace \
    ".spec.commonName = \"dev.cncf-demo.$DOMAIN\"" \
    kustomize/overlays/cert-manager/certificate.yaml

yq --inplace \
    ".spec.dnsNames[0] = \"dev.cncf-demo.$DOMAIN\"" \
    kustomize/overlays/cert-manager/certificate.yaml
```

## Do

```bash
yq --inplace \
    ".metadata.labels.\"cert-manager.io/cluster-issuer\" = \"production\"" \
    kustomize/base/ingress.yaml

yq --inplace \
    ".spec.tls[0].hosts[0] = \"dev.cncf-demo.$DOMAIN\"" \
    kustomize/base/ingress.yaml

yq --inplace \
    ".spec.tls[0].secretName = \"cncf-demo\"" \
    kustomize/base/ingress.yaml

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
  commonName: dev.cncf-demo.sillydemo.com
  dnsNames:
    - dev.cncf-demo.sillydemo.com
" | tee kustomize/base/certificate.yaml

yq --inplace \
    ".resources += \"certificate.yaml\"" \
    kustomize/base/kustomization.yaml

kubectl --namespace dev apply --kustomize kustomize/base

kubectl --namespace dev \
    get issuers,certificaterequests,certificates,orders,secrets

echo "https://dev.cncf-demo.$DOMAIN"

# Open it in a browser
```

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
yq --inplace \
    "del(.metadata.labels.\"cert-manager.io/cluster-issuer\")" \
    kustomize/base/ingress.yaml

yq --inplace \
    "del(.spec.tls)" \
    kustomize/base/ingress.yaml

rm kustomize/base/certificate.yaml

yq --inplace \
    "del(.resources[] | select(. == \"certificate.yaml\"))" \
    kustomize/base/kustomization.yaml

kubectl --namespace dev delete certificate cncf-demo    

kubectl --namespace dev apply --kustomize kustomize/base
```

## Continue The Adventure

[TODO:](TODO:)