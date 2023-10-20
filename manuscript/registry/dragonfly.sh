yq --inplace ".image = \"$IMAGE\"" settings.yaml

# Create the `values.yaml` configuration file with different container runtime,
# refer to https://d7y.io/docs/setup/install/helm-charts#runtime-configuration-guide-for-dragonfly-helm-chart.
cat > values.yaml << EOF
containerRuntime:
  docker:
    enable: true
    injectHosts: true
    registryDomains:
      - 'index.docker.io'
EOF

set +e
helm repo add dragonfly https://dragonflyoss.github.io/helm-charts/
set -e

helm repo update

helm install --create-namespace --namespace dragonfly-system dragonfly dragonfly/dragonfly -f values.yaml
