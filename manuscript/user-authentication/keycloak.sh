#!/bin/sh
set -e

gum confirm '
Are you ready to start?
Select "Yes" only if you did NOT follow the story from the start (if you jumped straight into this chapter).
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

INGRESS_CLASSNAME=$(yq ".ingress.classname" settings.yaml)

INGRESS_HOST=$(yq ".ingress.host" settings.yaml)

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

REPO_URL=$(git config --get remote.origin.url)

yq --inplace ".spec.ingressClassName = \"$INGRESS_CLASSNAME\"" \
    keycloak/ingress.yaml

yq --inplace \
    ".spec.rules[0].host = \"keycloak.$INGRESS_HOST\"" \
    keycloak/ingress.yaml

yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    $GITOPS_APP/keycloak.yaml

cp $GITOPS_APP/keycloak.yaml infra/.

APP_COUNTER_OLD=$(kubectl get applications --all-namespaces | wc -l)

git add .

git commit -m "Keycloak"

git push

APP_COUNTER=$(kubectl get applications --all-namespaces | wc -l)

while [ $APP_COUNTER_OLD = $APP_COUNTER ]; do
	sleep 10
	echo "Waiting for the application..."
	APP_COUNTER=$(kubectl get applications --all-namespaces | wc -l)
done