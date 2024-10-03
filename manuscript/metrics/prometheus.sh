#!/bin/sh
set -e

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

#########
# Setup #
#########

INGRESS_CLASSNAME=$(yq ".ingress.classname" settings.yaml)

INGRESS_HOST=$(yq ".ingress.host" settings.yaml)

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

if [[ "$GITOPS_APP" == "argocd" ]]; then

    echo "# Argo CD Issues

Argo CD has trouble working with the Prometheus Stack Helm chart so we'll install it manually.
" | gum format

    yq --inplace ".grafana.ingress.ingressClassName = \"$INGRESS_CLASSNAME\"" \
        prometheus/values.yaml

    yq --inplace ".grafana.ingress.hosts[0] = \"grafana.$INGRESS_HOST\"" \
        prometheus/values.yaml

    yq --inplace ".prometheus.ingress.ingressClassName = \"$INGRESS_CLASSNAME\"" \
        prometheus/values.yaml

    yq --inplace ".prometheus.ingress.hosts[0] = \"prometheus.$INGRESS_HOST\"" \
        prometheus/values.yaml

    helm upgrade --install \
        kube-prometheus-stack kube-prometheus-stack \
        --repo https://prometheus-community.github.io/helm-charts \
        --values prometheus/values.yaml --reuse-values \
        --namespace monitoring --create-namespace --wait

fi

if [[ "$GITOPS_APP" == "flux" ]]; then

    yq --inplace ".spec.values.grafana.ingress.ingressClassName = \"$INGRESS_CLASSNAME\"" \
        flux/prometheus-release.yaml

    yq --inplace ".spec.values.grafana.ingress.hosts[0] = \"grafana.$INGRESS_HOST\"" \
        flux/prometheus-release.yaml

    yq --inplace ".spec.values.prometheus.ingress.ingressClassName = \"$INGRESS_CLASSNAME\"" \
        flux/prometheus-release.yaml

    yq --inplace ".spec.values.prometheus.ingress.hosts[0] = \"prometheus.$INGRESS_HOST\"" \
        flux/prometheus-release.yaml

    cp $GITOPS_APP/prometheus*.yaml infra/.

    git add . 

    git commit -m "Prometheus"

    git push

fi

COUNTER=$(kubectl --namespace monitoring get pods --no-headers | wc -l)

while [ $COUNTER -eq "0" ]; do
	sleep 10
	COUNTER=$(kubectl --namespace monitoring get pods --no-headers | wc -l)
done
