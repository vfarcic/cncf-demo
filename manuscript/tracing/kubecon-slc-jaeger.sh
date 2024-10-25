#!/bin/sh
set -e

#########
# Setup #
#########

INGRESS_CLASSNAME=$(yq ".ingress.classname" settings.yaml)

INGRESS_HOST=$(yq ".ingress.host" settings.yaml)

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

yq --inplace ".spec.source.helm.parameters[7].value = \"$INGRESS_CLASSNAME\"" \
    argocd/jaeger.yaml

yq --inplace ".spec.source.helm.parameters[8].value = \"jaeger.$INGRESS_HOST\"" \
    argocd/jaeger.yaml
