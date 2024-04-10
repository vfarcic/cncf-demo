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

    yq --inplace ".spec.source.helm.parameters += {\"name\": \"grafana.datasources.datasources\.yaml.apiVersion\", \"value\": 1}" \
        argocd/prometheus.yaml

    yq --inplace ".spec.source.helm.parameters += {\"name\": \"grafana.datasources.datasources\.yaml.datasources[0].name\", \"value\": \"loki\"}" \
        argocd/prometheus.yaml

    yq --inplace ".spec.source.helm.parameters += {\"name\": \"grafana.datasources.datasources\.yaml.datasources[0].type\", \"value\": \"loki\"}" \
        argocd/prometheus.yaml

    yq --inplace ".spec.source.helm.parameters += {\"name\": \"grafana.datasources.datasources\.yaml.datasources[0].url\", \"value\": \"http://loki:3100\"}" \
        argocd/prometheus.yaml

    yq --inplace ".spec.source.helm.parameters += {\"name\": \"grafana.datasources.datasources\.yaml.datasources[0].access\", \"value\": \"proxy\"}" \
        argocd/prometheus.yaml

fi

if [[ "$GITOPS_APP" == "flux" ]]; then

    yq --inplace ".spec.values.grafana.datasources.\"datasources.yaml\".apiVersion = 1" \
        flux/prometheus-release.yaml

    yq --inplace ".spec.values.grafana.datasources.\"datasources.yaml\".datasources[0].name = \"loki\"" \
        flux/prometheus-release.yaml

    yq --inplace ".spec.values.grafana.datasources.\"datasources.yaml\".datasources[0].type = \"loki\"" \
        flux/prometheus-release.yaml

    yq --inplace ".spec.values.grafana.datasources.\"datasources.yaml\".datasources[0].url = \"http://loki:3100\"" \
        flux/prometheus-release.yaml

    yq --inplace ".spec.values.grafana.datasources.\"datasources.yaml\".datasources[0].access = \"proxy\"" \
        flux/prometheus-release.yaml

fi

# FIXME: Uncomment and adapt
# helm upgrade --install  logging-operator \
#     oci://ghcr.io/kube-logging/helm-charts/logging-operator \
#     --set testReceiver.enabled=true \
#     --namespace logging --create-namespace --wait

# FIXME: Uncomment and adapt
# helm upgrade --install loki loki \
#     --repo https://grafana.github.io/helm-charts \
#     --values loki-values.yaml \
#     --namespace logging --create-namespace --wait

# FIXME: Uncomment and adapt
# echo "http://grafana.$INGRESS_HOST.nip.io"

# FIXME: Uncomment and adapt
# kubectl --namespace logging get secret grafana \
#     --output jsonpath="{.data.admin-password}" | base64 -d

# FIXME: Uncomment and adapt
# FIXME: Use `admin` as the username and the output from the previous command as the password

# FIXME: Uncomment and adapt
# FIXME: Open `Explore` page from the left-hand menu

cp $GITOPS_APP/prometheus*.yaml infra/.

git add . 

git commit -m "Prometheus"

git push

COUNTER=$(kubectl --namespace monitoring get pods --no-headers | wc -l)

while [ $COUNTER -eq "0" ]; do
	sleep 10
	COUNTER=$(kubectl --namespace monitoring get pods --no-headers | wc -l)
done
