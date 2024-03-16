GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cp $GITOPS_APP/containerssh.yaml infra/.

git add .

git commit -m "OpenFGA"

git push

COUNTER=$(kubectl --namespace openfga get pods)

while [ -z "$COUNTER" ]; do
    sleep 10
    echo "Waiting for ContainerSSH to be ready..."
    COUNTER=$(kubectl --namespace containerssh get pods)
done

kubectl --namespace containerssh get service containerssh \
    --output jsonpath="{.status.loadBalancer.ingress[0].hostname}"

if [[ "$HYPERSCALER" == "aws" ]]; then

    CONTAINERSSH_INGRESS=$(kubectl --namespace containerssh \
        get service containerssh \
        --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

else

    CONTAINERSSH_INGRESS=$(kubectl --namespace containerssh \
        get service containerssh \
        --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

fi

echo "export CONTAINERSSH_INGRESS=$CONTAINERSSH_INGRESS" >> .env
yq --inplace \
    ".containerssh.ingress = \"$CONTAINERSSH_INGRESS\"" \
    settings.yaml