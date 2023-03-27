yq --inplace \
    ".[].value = \"cncf-demo-dev.$DOMAIN\"" \
    kustomize/overlays/dev/ingress.yaml

yq --inplace \
    ".spec.commonName = \"cncf-demo-dev.$DOMAIN\"" \
    kustomize/overlays/dev/certificate.yaml

yq --inplace \
    ".spec.dnsNames[0] = \"cncf-demo-dev.$DOMAIN\"" \
    kustomize/overlays/dev/certificate.yaml
