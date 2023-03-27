yq --inplace ".images.app.image = \"$IMAGE\"" devspace.yaml

yq --inplace \
    ".deployments.app.kubectl.manifests[0] = \"kustomize/overlays/dev\"" \
    devspace.yaml

yq --inplace \
    ".deployments.app.kubectl.kustomize = true" \
    devspace.yaml
