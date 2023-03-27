yq --inplace ".ingress.host = \"cncf-demo-dev.$DOMAIN\"" \
    cdk8s/app.yaml

yq --inplace ".image.repository = \"$IMAGE\"" cdk8s/app.yaml
