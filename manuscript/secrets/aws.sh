#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the' \
	'Managing Secrets From AWS With External Secrets Operator (ESO)' \
	'chapter.'

gum confirm '
Are you ready to start?
Select "Yes" only if you did NOT follow the story from the start (if you jumped straight into this chapter).
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|kubectl         |Yes                  |'https://kubernetes.io/docs/tasks/tools/#kubectl'  |
|AWS CLI         |Yes                  |'https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html'|
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

AWS_ACCESS_KEY_ID=$(gum input --placeholder "AWS Access Key ID" --value "$AWS_ACCESS_KEY_ID")
echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> .env
    
AWS_SECRET_ACCESS_KEY=$(gum input --placeholder "AWS Secret Access Key" --value "$AWS_SECRET_ACCESS_KEY" --password)
echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> .env

set +e
aws secretsmanager create-secret --name production-postgresql --region us-east-1 --secret-string '{"password": "YouWillNeverFindOut"}'
set -e

kubectl --namespace external-secrets create secret generic aws --from-literal access-key-id=$AWS_ACCESS_KEY_ID --from-literal secret-access-key=$AWS_SECRET_ACCESS_KEY

cp eso/secret-store-aws.yaml infra/.

git add .

git commit -m "Secret Store"

git push

COUNTER=$(kubectl --namespace external-secrets get clustersecretstores | wc -l)

while [ $COUNTER -eq 0 ]; do
	sleep 10
	COUNTER=$(kubectl --namespace external-secrets get clustersecretstores | wc -l)
done
