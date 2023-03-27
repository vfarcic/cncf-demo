yq --inplace ".images[0].name = \"$IMAGE\"" \
    kustomize/base/kustomization.yaml

yq --inplace ".images[0].newName = \"$IMAGE\"" \
    kustomize/base/kustomization.yaml

yq --inplace ".[].value = \"cncf-demo-dev.$DOMAIN\"" \
    kustomize/overlays/dev/ingress.yaml

yq --inplace \
    ".spec.template.spec.containers[0].image = \"$IMAGE\"" \
    kustomize/base/deployment.yaml

