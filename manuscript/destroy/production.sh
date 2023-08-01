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

	kubectl --namespace production delete --filename crossplane/aws-eks.yaml

    COUNTER=$(kubectl get managed | wc -l)

    while [ $COUNTER -ne 0 ]; do
        sleep 10
        COUNTER=$(kubectl get managed | wc -l)
    done

elif [[ "$HYPERSCALER" == "azure" ]]; then

	az group delete --name $RESOURCE_GROUP --yes

fi
