#!/bin/sh
set -e

#########
# Setup #
#########

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cp $GITOPS_APP/argo-rollouts.yaml infra/.

git add . 

git commit -m "Argo Rollouts"

git push
