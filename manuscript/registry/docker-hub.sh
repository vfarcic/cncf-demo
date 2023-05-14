#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Docker Hub Setup'

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

################
# Requirements #
################

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|Charm Gum       |Yes                  |'https://github.com/charmbracelet/gum#installation'|
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
|Docker          |Yes                  |'https://docs.docker.com/engine/install'           |
|Docker Hub account|Yes                |'https://hub.docker.com/signup'                    |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

rm -f .env

#########
# Setup #
#########

REGISTRY=index.docker.io

DOCKERHUB_USERNAME=$(gum input --placeholder "Docker Hub username" --value "$DOCKERHUB_USERNAME")

echo "export DOCKERHUB_USERNAME=$DOCKERHUB_USERNAME" >> .env

DOCKERHUB_PASSWORD=$(gum input --placeholder "Docker Hub password" --value "$DOCKERHUB_PASSWORD" --password)

IMAGE=$REGISTRY/$DOCKERHUB_USERNAME/cncf-demo

echo "export IMAGE=$IMAGE" >> .env

yq --inplace ".image = \"$IMAGE\"" settings.yaml

docker login --username $DOCKERHUB_USERNAME --password $DOCKERHUB_PASSWORD $REGISTRY

###########
# The End #
###########

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'The setup is almost finished.' \
    '
Execute "source .env" to set the environment variables.'
