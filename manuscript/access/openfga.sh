GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

INGRESS_CLASSNAME=$(yq ".ingress.classname" settings.yaml)

INGRESS_HOST=$(yq ".ingress.host" settings.yaml)

if [[ "$GITOPS_APP" == "argocd" ]]; then

    yq --inplace \
        ".spec.source.helm.parameters[1].value = \"$INGRESS_CLASSNAME\"" \
        argocd/openfga.yaml

    yq --inplace \
        ".spec.source.helm.parameters[2].value = \"openfga.$INGRESS_HOST\"" \
        argocd/openfga.yaml

fi

if [[ "$GITOPS_APP" == "flux" ]]; then

    yq --inplace ".spec.values.ingress.className = \"$INGRESS_CLASSNAME\"" \
        flux/openfga-release.yaml

    yq --inplace ".spec.values.ingress.hosts[0].host = \"openfga.$INGRESS_HOST\"" \
        flux/openfga-release.yaml

fi

cp $GITOPS_APP/openfga*.yaml infra/.

git add .

git commit -m "OpenFGA"

git push

COUNTER=$(kubectl --namespace openfga get pods)

while [ -z "$COUNTER" ]; do
    sleep 10
    echo "Waiting for OpenFGA to be ready..."
    COUNTER=$(kubectl --namespace openfga get pods)
done

FGA_API_URL="http://openfga.$INGRESS_HOST"
echo "export FGA_API_URL=$FGA_API_URL" >> .env
