#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the
  Create and Manage Production AWS EKS Cluster with Crossplane
  episode'

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
|kubectl         |Yes                  |'https://kubernetes.io/docs/tasks/tools/#kubectl'  |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#######
# AWS #
#######

AWS_ACCESS_KEY_ID=$(gum input --placeholder "AWS Access Key ID" --value "$AWS_ACCESS_KEY_ID")
echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> .env

AWS_SECRET_ACCESS_KEY=$(gum input --placeholder "AWS Secret Access Key" --value "$AWS_SECRET_ACCESS_KEY" --password)
echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> .env

echo "[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
" >aws-creds.conf

kubectl --namespace crossplane-system create secret generic aws-creds --from-file creds=./aws-creds.conf

kubectl apply --filename crossplane-config/provider-config-aws-official.yaml

yq --inplace ".crossplane.destination = \"aws\"" settings.yaml

echo "export HYPERSCALER=aws" >> .env
