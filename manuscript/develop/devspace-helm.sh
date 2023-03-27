yq --inplace ".images.app.image = \"$IMAGE\"" devspace.yaml

yq --inplace \
    ".deployments.app.helm.chart.name = \"helm/app\"" \
    devspace.yaml

yq --inplace \
    ".deployments.app.helm.releaseName = \"cncf-demo\"" \
    devspace.yaml
