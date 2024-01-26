#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the' \
	'Managing Secrets In Kubernetes With Secrets OPerationS (SOPS)' \
	'chapter.'

gum confirm '
Are you ready to start?
Select "Yes" only if you did NOT follow the story from the start (if you jumped straight into this chapter).
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|kubectl         |Yes                  |'https://kubernetes.io/docs/tasks/tools/#kubectl'  |
|sops            |Yes                  |'https://github.com/getsops/sops/releases'  |
|age             |Yes                  |'https://github.com/FiloSottile/age'  |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

AGE_KEY=$(age-keygen | grep -v '\#')
AGE_PUBKEY=$(echo "${AGE_KEY}" | age-keygen -y)

echo ${AGE_KEY} |
	kubectl create secret generic sops-age \
		--namespace=flux-system \
		--from-file=age.agekey=/dev/stdin

yq --inplace ".secrets = \"sops\"" settings.yaml
yq --inplace ".sops.pubkey = \"${AGE_PUBKEY}\"" settings.yaml
