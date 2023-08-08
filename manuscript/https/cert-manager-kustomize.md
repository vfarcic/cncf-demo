# Use HTTPS With cert-manager And Kustomize

## Setup

```bash
chmod +x manuscript/https/cert-manager-kustomize.sh

./manuscript/https/cert-manager-kustomize.sh
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

* [Set Up PostgreSQL DB in the Dev Environment](../db/README.md)
