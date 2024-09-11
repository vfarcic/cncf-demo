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

yq --inplace ".spec.ingressClassName = \"$INGRESS_CLASSNAME\"" \
    headlamp/ingress.yaml

yq --inplace \
    ".spec.rules[0].host = \"dashboard.$INGRESS_HOST\"" \
    headlamp/ingress.yaml

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cp $GITOPS_APP/headlamp.yaml infra/.

cp headlamp/ingress.yaml infra/headlamp-ingress.yaml

cp headlamp/sa.yaml infra/headlamp-sa.yaml

git add .

git commit -m "Skooner"

git push

echo "## Waiting for Headlamp to be ready..." | gum format

COUNTER=$(kubectl --namespace headlamp get pods --no-headers | wc -l)

while [ $COUNTER -eq "0" ]; do
	sleep 10
	COUNTER=$(kubectl --namespace headlamp get pods --no-headers | wc -l)
done

sleep 5

TOKEN=$(kubectl --namespace headlamp create token headlamp-sa)

echo "
## Use the following token to login to headlamp:

$TOKEN
" | gum format
