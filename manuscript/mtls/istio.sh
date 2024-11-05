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

HYPERSCALER=$(yq ".hyperscaler" settings.yaml)

helm upgrade --install istio-base base \
    --repo https://istio-release.storage.googleapis.com/charts \
    --namespace istio-system --create-namespace --wait

helm upgrade --install istiod istiod \
    --repo https://istio-release.storage.googleapis.com/charts \
    --namespace istio-system --wait

helm upgrade --install istio-ingress gateway \
    --repo https://istio-release.storage.googleapis.com/charts \
    --namespace istio-system

helm upgrade --install kiali-operator kiali-operator \
    --repo https://kiali.org/helm-charts \
    --namespace kiali-operator --create-namespace \
    --set cr.create=true --set cr.namespace=istio-system \
    --set cr.spec.auth.strategy="anonymous" \
    --set cr.spec.external_services.prometheus.url="http://kube-prometheus-stack-prometheus.monitoring:9090/" \
    --wait

COUNTER=$(kubectl --namespace istio-system get pods --no-headers | wc -l)

while [ $COUNTER -eq "0" ]; do
	sleep 10
	COUNTER=$(kubectl --namespace istio-system get pods --no-headers | wc -l)
done

if [[ "$HYPERSCALER" == "aws" ]]; then

    ISTIO_HOSTNAME=$(kubectl --namespace istio-system \
        get service istio-ingress \
        --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")
    while [ -z "$ISTIO_HOSTNAME" ]; do
        sleep 10
        echo "Waiting for Gateway IP..."
        ISTIO_HOSTNAME=$(kubectl --namespace istio-system \
            get service istio-ingress \
            --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")
    done

    ISTIO_IP=$(dig +short $ISTIO_HOSTNAME) 

    while [ -z "$ISTIO_IP" ]; do
        sleep 10
        echo "Waiting for Gateway IP..."
        ISTIO_HOSTNAME=$(kubectl --namespace istio-system \
            get service istio-ingress \
            --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")
        ISTIO_IP=$(dig +short $ISTIO_HOSTNAME)  
    done

else

    ISTIO_IP=$(kubectl --namespace istio-system \
        get service istio-ingress \
        --output jsonpath="{.status.loadBalancer.ingress[0].ip}")
    while [ -z "$ISTIO_IP" ]; do
        sleep 10
        echo "Waiting for Gateway IP..."
        ISTIO_IP=$(kubectl --namespace istio-system \
            get service istio-ingress \
            --output jsonpath="{.status.loadBalancer.ingress[0].ip}")
    done

fi

ISTIO_IP=$(echo $ISTIO_IP | awk '{print $1;}')

ISTIO_IP_LINES=$(echo $ISTIO_IP | wc -l | tr -d ' ')

if [ $ISTIO_IP_LINES -gt 1 ]; then
    ISTIO_IP=$(echo $ISTIO_IP | head -n 1)
fi

echo "export ISTIO_IP=$ISTIO_IP" >> .env

ISTIO_HOST=$ISTIO_IP.nip.io
echo "export ISTIO_HOST=$ISTIO_HOST" >> .env

kubectl --namespace istio-system delete pods \
    --selector app=gateway

cp istio/namespace-production.yaml apps/.

git add . 

git commit -m "Istio"

git push
