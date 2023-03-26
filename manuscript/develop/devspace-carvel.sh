yq --inplace ".images.app.image = \"$IMAGE\"" devspace.yaml

yq --inplace \
    ".deployments.app.kubectl.manifests[0] = \"yaml/dev\"" \
    devspace.yaml

export RUN_COMMANDS="ytt --file ytt/schema.yaml --file ytt/resources --data-values-file ytt/values-dev.yaml | tee yaml/dev/app.yaml
create_deployments --all
start_dev app"

yq --inplace \
    ".pipelines.dev.run = \"$RUN_COMMANDS\"" \
    devspace.yaml
