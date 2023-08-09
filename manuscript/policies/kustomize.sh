#!/bin/sh
set -e

rm -f .env

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the Policies With Kustomize chapter.'

gum confirm '
Are you ready to start?
Select "Yes" only if you did NOT follow the story from the start (if you jumped straight into this chapter).
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|git             |Yes                  |'https://git-scm.com/book/en/v2/Getting-Started-Installing-Git'|
|kubectl         |Yes                  |'https://kubernetes.io/docs/tasks/tools/#kubectl'  |
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

rm -f apps/cncf-demo.yaml

git add .

git commit -m "Starting over with policies by removing the app"

git push

kubectl --namespace production get all,ingresses

COUNTER=$(kubectl --namespace production get all,ingresses | wc -l)

while [ $COUNTER -ne 0 ]; do
    sleep 10
    COUNTER=$(kubectl --namespace production get all,ingresses | wc -l)
done

DESTINATION=$(yq ".crossplane.destination" settings.yaml)
echo "export DESTINATION=$DESTINATION" >> .env
