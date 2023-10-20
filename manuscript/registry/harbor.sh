yq --inplace \
    ".spec.commonName = \"harbor.$DOMAIN\"" \
    harbor/certificate.yaml

yq --inplace \
    ".spec.dnsNames[0] = \"harbor.$DOMAIN\"" \
    harbor/certificate.yaml

yq --inplace \
    ".expose.ingress.hosts.core = \"harbor.$DOMAIN\"" \
    harbor/values.yaml

yq --inplace \
    ".expose.ingress.hosts.notary = \"notary.$DOMAIN\"" \
    harbor/values.yaml

yq --inplace \
    ".externalURL = \"https://harbor.$DOMAIN\"" \
    harbor/values.yaml

set +e
helm repo add harbor https://helm.goharbor.io
set -e

helm repo update

helm upgrade --install harbor harbor/harbor \
    --namespace harbor --create-namespace \
    --values harbor/values.yaml --timeout 15m0s --wait

kubectl --namespace harbor apply \
    --filename harbor/certificate.yaml

export REGISTRY=harbor.$DOMAIN

export IMAGE=$REGISTRY/library/cncf-demo

yq --inplace ".image = \"$IMAGE\"" settings.yaml

docker login --username admin --password Harbor12345 $REGISTRY
