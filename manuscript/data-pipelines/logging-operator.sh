#!/bin/sh
set -e

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|git             |Yes                  |'https://git-scm.com/book/en/v2/Getting-Started-Installing-Git'|
|kubectl         |Yes                  |'https://kubernetes.io/docs/tasks/tools/#kubectl'  |
|helm            |Yes                  |'https://helm.sh/docs/intro/install/'              |
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

INGRESS_CLASSNAME=$(yq ".ingress.classname" settings.yaml)

INGRESS_HOST=$(yq ".ingress.host" settings.yaml)

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

if [[ "$GITOPS_APP" == "argocd" ]]; then

    yq --inplace \
        ".grafana.ingress.ingressClassName = \"$INGRESS_CLASSNAME\"" \
        prometheus/values.yaml

    yq --inplace \
        ".grafana.ingress.hosts[0] = \"grafana.$INGRESS_HOST\"" \
        prometheus/values.yaml

    yq --inplace ".prometheus.ingress.ingressClassName = \"$INGRESS_CLASSNAME\"" \
        prometheus/values.yaml

    yq --inplace ".prometheus.ingress.hosts[0] = \"prometheus.$INGRESS_HOST\"" \
        prometheus/values.yaml

    yq --inplace \
        ".grafana.datasources.\"datasources.yaml\".apiVersion = 1" \
        prometheus/values.yaml

    yq --inplace \
        ".grafana.datasources.\"datasources.yaml\".datasources[0].name = \"loki\"" \
        prometheus/values.yaml

    yq --inplace \
        ".grafana.datasources.\"datasources.yaml\".datasources[0].type = \"loki\"" \
        prometheus/values.yaml

    yq --inplace \
        ".grafana.datasources.\"datasources.yaml\".datasources[0].url = \"http://loki:3100\"" \
        prometheus/values.yaml

    yq --inplace \
        ".grafana.datasources.\"datasources.yaml\".datasources[0].access = \"proxy\"" \
        prometheus/values.yaml

    helm upgrade --install \
        kube-prometheus-stack kube-prometheus-stack \
        --repo https://prometheus-community.github.io/helm-charts \
        --values prometheus/values.yaml \
        --namespace monitoring --create-namespace --wait

    cp argocd/loki.yaml infra/.

fi

if [[ "$GITOPS_APP" == "flux" ]]; then

    yq --inplace \
        ".spec.values.grafana.ingress.ingressClassName = \"$INGRESS_CLASSNAME\"" \
        flux/prometheus-release.yaml

    yq --inplace \
        ".spec.values.grafana.ingress.hosts[0] = \"grafana.$INGRESS_HOST\"" \
        flux/prometheus-release.yaml

    yq --inplace \
        ".spec.values.prometheus.ingress.ingressClassName = \"$INGRESS_CLASSNAME\"" \
        flux/prometheus-release.yaml

    yq --inplace \
        ".spec.values.prometheus.ingress.hosts[0] = \"prometheus.$INGRESS_HOST\"" \
        flux/prometheus-release.yaml

    yq --inplace \
        ".spec.values.grafana.datasources.\"datasources.yaml\".apiVersion = 1" \
        flux/prometheus-release.yaml

    yq --inplace \
        ".spec.values.grafana.datasources.\"datasources.yaml\".datasources[0].name = \"loki\"" \
        flux/prometheus-release.yaml

    yq --inplace \
        ".spec.values.grafana.datasources.\"datasources.yaml\".datasources[0].type = \"loki\"" \
        flux/prometheus-release.yaml

    yq --inplace \
        ".spec.values.grafana.datasources.\"datasources.yaml\".datasources[0].url = \"http://loki:3100\"" \
        flux/prometheus-release.yaml

    yq --inplace \
        ".spec.values.grafana.datasources.\"datasources.yaml\".datasources[0].access = \"proxy\"" \
        flux/prometheus-release.yaml

    cp flux/prometheus*.yaml infra/.

    cp flux/grafana-repo.yaml infra/.

    cp flux/loki-release.yaml infra/.

fi

helm upgrade --install logging-operator \
    oci://ghcr.io/kube-logging/helm-charts/logging-operator \
    --namespace monitoring --create-namespace --wait

cp logging-operator/common.yaml \
    infra/logging-operator-common.yaml

git add . 

git commit -m "Logging Operator"

git push
