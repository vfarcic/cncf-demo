yq --inplace ".images.app.image = \"$IMAGE\"" devspace.yaml

yq --inplace \
    ".deployments.app.kubectl.manifests[0] = \"yaml/dev\"" \
    devspace.yaml

export RUN_COMMANDS="cd cdk8s
cdk8s synth --output ../yaml/dev --validate
cd ..
create_deployments --all
start_dev app"

yq --inplace ".pipelines.dev.run = \"$RUN_COMMANDS\"" \
    devspace.yaml
