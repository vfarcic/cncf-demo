#!/bin/sh
set -e

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

if [ -n "$1" ]; then
    yq --inplace \
        ".spec.source.helm.valuesObject.meshProvider = \"$1\"" \
        $GITOPS_APP/flagger.yaml
fi

cp $GITOPS_APP/flagger.yaml infra/.

git add . 

git commit -m "Argo Rollouts"

git push
