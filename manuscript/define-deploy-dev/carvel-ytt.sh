yq --inplace ".ingress.host = \"cncf-demo-dev.$DOMAIN\"" \
    ytt/schema.yaml

yq --inplace ".image.repository = \"$IMAGE\"" \
    ytt/schema.yaml
