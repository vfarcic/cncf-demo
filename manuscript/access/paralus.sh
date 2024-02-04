#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the Access Control With Paralus chapter.'

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

INGRESS_HOST=$(yq ".ingress.host" settings.yaml)

yq --inplace ".spec.source.helm.parameters[0].value = \"paralus.$INGRESS_HOST\"" argocd/paralus.yaml

INGRESS_CLASS=$(yq ".ingress.classname" settings.yaml)

yq --inplace ".spec.source.helm.parameters[1].value = \"$INGRESS_CLASS\"" argocd/paralus.yaml

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cp $GITOPS_APP/paralus*.yaml infra/.

git add .

git commit -m "Paralus"

git push

COUNTER=$(kubectl --namespace paralus get pods --no-headers | wc -l)

while [ $COUNTER -eq "0" ]; do
	sleep 10
	COUNTER=$(kubectl --namespace paralus get pods --no-headers | wc -l)
done
