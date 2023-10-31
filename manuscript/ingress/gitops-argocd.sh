#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the Ingress For Argo CD chapter.'

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

if [ -z "$INGRESS_IP" ]; then
	INGRESS_IP=$(yq ".production.ingress.ip" settings.yaml)
fi

DOMAIN=$(gum input --placeholder "Domain" --value "$INGRESS_IP.nip.io")
echo "export DOMAIN=$DOMAIN" >> .env

yq --inplace ".production.domain = \"$DOMAIN\"" settings.yaml

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
    "Use the IP $INGRESS_IP to configure DNS for the following subdomains." \
	"(Skip this step if you chose to use `nip.io` instead of a "real" domain.)
- gitops.$DOMAIN"

gum confirm "
Continue?
" || exit 0

if [ -z "$INGRESS_CLASS_NAME" ]; then
	INGRESS_CLASS_NAME=$(yq ".production.ingress.className" settings.yaml)
	echo "export INGRESS_CLASS_NAME=$INGRESS_CLASS_NAME" >> .env
fi
