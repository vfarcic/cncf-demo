#!/bin/sh
set -e

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|git             |Yes                  |'https://git-scm.com/book/en/v2/Getting-Started-Installing-Git'|
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cp $GITOPS_APP/argo-rollouts.yaml infra/.

git add . 

git commit -m "Argo Rollouts"

git push

COUNTER=$(kubectl --namespace argo-rollouts get pods \
    --no-headers | wc -l)

while [ $COUNTER -eq "0" ]; do
	sleep 10
	COUNTER=$(kubectl --namespace argo-rollouts get pods \
        --no-headers | wc -l)
done

echo "export PD_APP=argo-rollouts" >> .env
