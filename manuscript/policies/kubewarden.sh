#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the Policies With Kubewarden chapter.'

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|git             |Yes                  |'https://git-scm.com/book/en/v2/Getting-Started-Installing-Git'|
|kubectl         |Yes                  |'https://kubernetes.io/docs/tasks/tools/#kubectl'  |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

rm -f apps/cncf-demo.yaml

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cp $GITOPS_APP/cert-manager.yaml infra/.

cp $GITOPS_APP/kubewarden.yaml infra/.

git add . 

git commit -m "Kyverno"

git push

COUNTER=$(kubectl --namespace kubewarden get pods --no-headers | wc -l)

while [ $COUNTER -eq "0" ]; do
	sleep 10
	COUNTER=$(kubectl --namespace kubewarden get pods --no-headers | wc -l)
done
