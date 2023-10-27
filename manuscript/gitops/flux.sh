#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the GitOps With Carvel kapp-controller chapter.'

gum confirm '
Are you ready to start?
Select "Yes" only if you did NOT follow the story from the start (if you jumped straight into this chapter).
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|yq CLI          |Yes                  |'https://github.com/mikefarah/yq#install'          |
|flux CLI        |Yes                  |'https://fluxcd.io/flux/get-started/#install-the-flux-cli'|
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

export REPO_URL=$(git config --get remote.origin.url)

GITHUB_TOKEN=$(gum input --placeholder "GitHub token" --value "$AWS_ACCESS_KEY_ID" --password)
echo "export GITHUB_TOKEN=$GITHUB_TOKEN" >> .env

GITHUB_USER=$(gum input --placeholder "GitHub user" --value "$GITHUB_USER" --password)
echo "export GITHUB_USER=$GITHUB_USER" >> .env

GITHUB_ORG=$(gum input --placeholder "GitHub organization" --value "$GITHUB_ORG" --password)
echo "export GITHUB_ORG=$GITHUB_ORG" >> .env
