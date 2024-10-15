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

COUNTER=$(kubectl --namespace flagger-system get pods \
    --no-headers | wc -l)

while [ $COUNTER -eq "0" ]; do
	sleep 10
	COUNTER=$(kubectl --namespace flagger-system get pods \
        --no-headers | wc -l)
done

echo "export PD_APP=flagger" >> .env
