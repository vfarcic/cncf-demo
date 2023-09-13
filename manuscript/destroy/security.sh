#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Destroy everything created in the Security chapter'

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

################
# Hyperscalers #
################

if [[ "$HYPERSCALER" == "google" ]]; then

    gcloud projects delete ${PROJECT_ID} --quiet

	set +e

	gcloud projects delete cncf-demo-db --quiet

	set -e

elif [[ "$HYPERSCALER" == "aws" ]]; then

	set +e

	rm apps/cncf-demo.yaml

	git add .

	git commit -m "Remove the app and the database"

	git push

	set -e

	COUNTER=$(kubectl get managed | wc -l)

    while [ $COUNTER -ne 0 ]; do
        sleep 10
        COUNTER=$(kubectl get managed | wc -l)
    done

	eksctl delete addon --name aws-ebs-csi-driver --cluster dot

	eksctl delete cluster --config-file eksctl/config-dev.yaml

elif [[ "$HYPERSCALER" == "azure" ]]; then

	az group delete --name $RESOURCE_GROUP --yes

	az group delete --name cncf-demo-db --yes

fi
