#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the Mutual TLS (mTLS) And Network Policies With Istio chapter.'

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
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cp $GITOPS_APP/istio.yaml infra/.

git add . 

git commit -m "Istio"

git push

COUNTER=$(kubectl --namespace istio-system get pods --no-headers | wc -l)

while [ $COUNTER -eq "0" ]; do
	sleep 10
	COUNTER=$(kubectl --namespace istio-system get pods --no-headers | wc -l)
done

ISTIO_IP=$(kubectl --namespace istio-system \
    get service istio-ingress \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")
while [ -z "$ISTIO_IP" ]; do
    sleep 10
    ISTIO_IP=$(kubectl --namespace istio-system \
    get service istio-ingress \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")
done
echo "export ISTIO_IP=$ISTIO_IP" >> .env

ISTIO_HOST=$ISTIO_IP.nip.io
echo "export ISTIO_HOST=$ISTIO_HOST" >> .env
