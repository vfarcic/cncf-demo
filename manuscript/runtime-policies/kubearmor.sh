#!/bin/sh
set -e

rm -f .env

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the Runtime Policies With KubeArmor chapter.'

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

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

REPO_URL=$(git config --get remote.origin.url)

yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/kubearmor.yaml

echo 'Please enter sudo password to install `karmor` CLI.'

curl -sfL http://get.kubearmor.io/ \
    | sudo sh -s -- -b /usr/local/bin

mkdir kubearmor

karmor install --save

mv kubearmor.yaml kubearmor/.

cp $GITOPS_APP/kubearmor.yaml infra/.

APP_COUNTER_OLD=$(kubectl get applications --all-namespaces | wc -l)

git add .

git commit -m "KubeArmor"

git push

APP_COUNTER=$(kubectl get applications --all-namespaces | wc -l)

while [ $APP_COUNTER_OLD = $APP_COUNTER ]; do
	sleep 10
	APP_COUNTER=$(kubectl get applications --all-namespaces | wc -l)
done
