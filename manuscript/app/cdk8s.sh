#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the Deploy The App Defined As cdk8s To Production With GitOps chapter.'

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

if [ -z "$GITOPS_APP" ]; then
	GITOPS_APP=$(yq ".gitOps.app" settings.yaml)
	echo "export GITOPS_APP=$GITOPS_APP" >> .env
fi

if [ -z "$DOMAIN" ]; then
	DOMAIN=$(yq ".production.domain" settings.yaml)
	echo "export DOMAIN=$DOMAIN" >> .env
fi

if [ -z "$INGRESS_CLASS_NAME" ]; then
	INGRESS_CLASS_NAME=$(yq ".production.ingress.className" settings.yaml)
	echo "export INGRESS_CLASS_NAME=$INGRESS_CLASS_NAME" >> .env
fi

if [[ "$GITOPS_APP" == "argocd" ]]; then
	REPO_URL=$(git config --get remote.origin.url)
	yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" $GITOPS_APP/cncf-demo-cdk8s.yaml
fi

if [[ "$GITOPS_APP" == "kapp-controller" ]]; then
	REPO_URL=$(git config --get remote.origin.url)
	yq --inplace ".spec.fetch[0].git.url = \"$REPO_URL\"" $GITOPS_APP/cncf-demo-cdk8s.yaml
fi

if [ -z "$TAG" ]; then
	TAG=$(yq ".tag" settings.yaml)
	echo "export TAG=$TAG" >> .env
fi

if [ -z "$INGRESS_IP" ]; then
	INGRESS_IP=$(yq ".production.ingress.ip" settings.yaml)
fi

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
    "Use the IP $INGRESS_IP to configure DNS for the following subdomains." \
	'(Skip this step if you chose to use `nip.io` instead of a "real" domain.)
- cncf-demo'

gum confirm "
Continue?
" || exit 0
