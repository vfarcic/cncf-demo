#!/bin/sh
set -e

source .env

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Destroy everything created in the Production chapter'

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

################
# Hyperscalers #
################

if [[ "$HYPERSCALER" == "google" ]]; then

    gcloud projects delete ${PROJECT_ID} --quiet

elif [[ "$HYPERSCALER" == "aws" ]]; then

	rm -rf yaml/prod/*.yaml

    rm -rf infra/*.yaml

    git add .

    git commit -m "Destroy"

    git push

    set +e
    COUNTER=$(kubectl get managed --no-headers | grep -v object | grep -v release | grep -v database | wc -l)

    while [ $COUNTER -ne 0 ]; do
        sleep 10
        echo "Waiting for $COUNTER resources to be deleted"
        COUNTER=$(kubectl get managed --no-headers | grep -v object | grep -v release | grep -v database | wc -l)
    done
    set -e

    unset KUBECONFIG

    set +e
    kubectl --namespace production delete --filename crossplane/aws-eks.yaml

    COUNTER=$(kubectl get managed --no-headers | grep -v object | grep -v release | wc -l)

    while [ $COUNTER -ne 0 ]; do
        sleep 10
        echo "Waiting for $COUNTER resources to be deleted"
        COUNTER=$(kubectl get managed --no-headers | grep -v object | grep -v release | wc -l)
    done

    kubectl delete --filename capi/aws-eks.yaml

    clusterawsadm bootstrap iam delete-cloudformation-stack --config capi-config/capa-iam-config.yaml

    set -e

elif [[ "$HYPERSCALER" == "azure" ]]; then

	az group delete --name $RESOURCE_GROUP --yes

fi
