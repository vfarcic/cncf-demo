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
|kubectl         |Yes                  |'https://kubernetes.io/docs/tasks/tools/#kubectl'  |
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

INGRESS_CLASSNAME=$(yq ".ingress.classname" settings.yaml)

INGRESS_HOST=$(yq ".ingress.host" settings.yaml)

GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

if [[ "$GITOPS_APP" == "argocd" ]]; then

    yq --inplace ".spec.source.helm.parameters[7].value = \"$INGRESS_CLASSNAME\"" \
        argocd/jaeger.yaml

    yq --inplace ".spec.source.helm.parameters[8].value = \"jaeger.$INGRESS_HOST\"" \
        argocd/jaeger.yaml

fi

if [[ "$GITOPS_APP" == "flux" ]]; then

    yq --inplace ".spec.values.allInOne.ingress.ingressClassName = \"$INGRESS_CLASSNAME\"" \
        flux/jaeger-release.yaml

    yq --inplace ".spec.values.allInOne.ingress.hosts[0] = \"jaeger.$INGRESS_HOST\"" \
        flux/jaeger-release.yaml

fi

cp $GITOPS_APP/jaeger*.yaml infra/.

git add . 

git commit -m "Prometheus"

git push

COUNTER=$(kubectl --namespace monitoring get pods \
    --selector app.kubernetes.io/name=jaeger --no-headers \
    | wc -l)

while [ $COUNTER -eq "0" ]; do
	sleep 10
    echo "Waiting for Jaeger to be ready..."
	COUNTER=$(kubectl --namespace monitoring get pods \
        --selector app.kubernetes.io/name=jaeger --no-headers \
        | wc -l)
done
