yq --inplace ".ingress.host = \"cncf-demo-dev.$DOMAIN\"" \
    helm/app/values.yaml

yq --inplace ".image.repository = \"$IMAGE\"" \
    helm/app/values.yaml
