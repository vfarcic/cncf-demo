#!/bin/sh
set -e

#########
# Setup #
#########

yq --inplace ".istio.enabled = true" \
    ytt/values-prod.yaml

yq --inplace ".istio.host = \"cncf-demo.$ISTIO_HOST\"" \
    ytt/values-prod.yaml

yq --inplace ".istio.host = \"cncf-demo.$ISTIO_HOST\"" \
    ytt/values-prod.yaml

yq --inplace ".progressiveDelivery.stepDuration = 10" \
    ytt/values-prod.yaml
