set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Destroy everything created in the Development chapter'

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

################
# Requirements #
################

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|Charm Gum       |Yes                  |'https://github.com/charmbracelet/gum#installation'|
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
|Google Cloud CLI|If using Google Cloud|'https://cloud.google.com/sdk/docs/install'        |
|AWS CLI         |If using AWS         |'https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html'|
|eksctl          |If using AWS         |'https://eksctl.io/installation/'                  |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

rm -f .env

echo "
Which Hyperscaler are you using?"

HYPERSCALER=$(gum choose "google" "aws" "azure" "other")

###########
# Destroy #
###########

if [[ "$HYPERSCALER" == "google" ]]; then

	PROJECT_ID=$(yq ".google.projectId" settings.yaml)

	gcloud projects delete $PROJECT_ID --quiet

	PROJECT_ID=$(yq ".production.google.projectId" settings.yaml)

	gcloud projects delete $PROJECT_ID --quiet

elif [[ "$HYPERSCALER" == "aws" ]]; then

	rm -rf infra/*.yaml

	rm -rf apps/*.yaml

	git add .

	git commit -m "Destroy everything"

	git push

	kubectl --namespace production delete sqlclaim cncf-demo

	COUNTER=$(kubectl get managed | wc -l)

    while [ $COUNTER -ne 0 ]; do
        sleep 10
        COUNTER=$(kubectl get managed | wc -l)
    done

	unset KUBECONFIG

	KUBECONFIG=$PWD/kubeconfig-dev.yaml

	kubectl --namespace dev delete sqlclaim cncf-demo

	kubectl --namespace production delete clusterclaim production

    COUNTER=$(kubectl get managed | wc -l)

    while [ $COUNTER -ne 0 ]; do
        sleep 10
        COUNTER=$(kubectl get managed | wc -l)
    done

	helm delete harbor --namespace harbor

	eksctl delete addon --name aws-ebs-csi-driver --cluster dot

	eksctl delete cluster --config-file eksctl/config-dev.yaml

elif [[ "$HYPERSCALER" == "azure" ]]; then

	RESOURCE_GROUP=$(yq ".azure.resourceGroup" settings.yaml)

	az group delete --name $RESOURCE_GROUP --yes

	az group delete --name cncf-demo-db-dev --yes

	az group delete --name production --yes

	az group delete --name cncf-demo-db --yes

fi


###########
# The End #
###########

if [[ "$HYPERSCALER" == "other" ]]; then

	gum style \
		--foreground 212 --border-foreground 212 --border double \
		--margin "1 2" --padding "2 4" \
		'If you created the dev/management cluster yourself instead
of following the instructions in the "Development" section,
destroy or reset all the resources manually.'

else

	gum style \
		--foreground 212 --border-foreground 212 --border double \
		--margin "1 2" --padding "2 4" \
		'The destruction is complete.'

fi
