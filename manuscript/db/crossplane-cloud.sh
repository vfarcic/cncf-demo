#!/bin/sh
set -e

set +e
helm repo add crossplane-stable https://charts.crossplane.io/stable
set -e

helm repo update

helm upgrade --install crossplane crossplane-stable/crossplane \
    --namespace crossplane-system --create-namespace --wait

kubectl apply \
    --filename crossplane-config/provider-kubernetes-incluster.yaml

kubectl apply --filename crossplane-config/config-sql.yaml
