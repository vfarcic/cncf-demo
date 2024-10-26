#!/bin/sh
set -e

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

	set +e

	rm infra/*.yaml

	rm apps/cncf-demo.yaml

	git add .

	git commit -m "Remove the app and the database"

	git push

	set -e

	COUNTER=$(kubectl get managed --no-headers | grep -v database | wc -l)

    while [ $COUNTER -ne 0 ]; do
        sleep 10
		echo "Waiting for $COUNTER resources to be deleted"
        COUNTER=$(kubectl get managed --no-headers | grep -v database | wc -l)
    done

	eksctl delete addon --name aws-ebs-csi-driver --cluster dot-production --region us-east-1

	eksctl delete nodegroup --name primary --cluster dot-production --drain=false --region us-east-1 --wait

	eksctl delete cluster --config-file eksctl/config-cilium.yaml --wait

elif [[ "$HYPERSCALER" == "azure" ]]; then

	az group delete --name $RESOURCE_GROUP --yes

	az group delete --name cncf-demo-db --yes

fi

rm -f $KUBECONFIG
