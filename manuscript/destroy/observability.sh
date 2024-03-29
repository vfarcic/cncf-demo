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
	helm --namespace kube-system delete cilium
	set -e

	eksctl delete addon --name aws-ebs-csi-driver --cluster dot-production --region us-east-1

	eksctl delete nodegroup --name primary --cluster dot-production --drain=false --region us-east-1 --wait

	eksctl delete cluster --config-file eksctl/config-cilium.yaml --wait

elif [[ "$HYPERSCALER" == "azure" ]]; then

	az group delete --name $RESOURCE_GROUP --yes

	az group delete --name cncf-demo-db --yes

fi
