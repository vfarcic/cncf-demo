#!/bin/sh
set -e

#########
# Setup #
#########

INGRESS_CLASSNAME=$(yq ".ingress.classname" settings.yaml)

INGRESS_HOST=$(yq ".ingress.host" settings.yaml)

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

yq --inplace ".grafana.ingress.ingressClassName = \"$INGRESS_CLASSNAME\"" \
    prometheus/values.yaml

yq --inplace ".grafana.ingress.hosts[0] = \"grafana.$INGRESS_HOST\"" \
    prometheus/values.yaml

yq --inplace ".prometheus.ingress.ingressClassName = \"$INGRESS_CLASSNAME\"" \
    prometheus/values.yaml

yq --inplace ".prometheus.ingress.hosts[0] = \"prometheus.$INGRESS_HOST\"" \
    prometheus/values.yaml
