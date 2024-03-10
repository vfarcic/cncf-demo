#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the Runtime Policies With KubeArmor chapter.'

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
|karmor          |Yes                  |'https://docs.kubearmor.io/kubearmor/quick-links/deployment_guide#install-karmor-cli-optional'|
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
    $GITOPS_APP/kubearmor.yaml

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
