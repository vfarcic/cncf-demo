#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the Runtime Policies With Falco chapter.'

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

#########
# Setup #
#########

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

REPO_URL=$(git config --get remote.origin.url)

cp $GITOPS_APP/falco.yaml infra/.

APP_COUNTER_OLD=$(kubectl get applications --all-namespaces | wc -l)

git add .

git commit -m "Falco"

git push

APP_COUNTER=$(kubectl get applications --all-namespaces | wc -l)

while [ $APP_COUNTER_OLD = $APP_COUNTER ]; do
	sleep 10
	APP_COUNTER=$(kubectl get applications --all-namespaces | wc -l)
done

sleep 5

kubectl --namespace falco rollout status daemonset falco \
	--timeout=15m
