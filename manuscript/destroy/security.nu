#!/usr/bin/env nu

let continue = [Yes No]
    | input list $"Destroy everything created in the Security chapter
(ansi green_bold)Are you ready to start?(ansi reset)
Feel free to say (ansi yellow_bold)No(ansi reset) and inspect the script if you prefer setting up resources manually.(ansi yellow_bold)
"

if continue == No { exit }

print $"(ansi purple_bold)
################
# Hyperscalers #
################
(ansi reset)"

do --ignore-errors {

	rm apps/cncf-demo.yaml

	git add .

	git commit -m "Remove the app and the database"

	git push
}

let hyperscaler = open settings.yaml | get hyperscaler

if $hyperscaler == "google" {

	let project_id = open settings.yaml
		| get production.google.projectId

    gcloud projects delete $project_id --quiet

	do --ignore-errors {
		gcloud projects delete cncf-demo-db --quiet | complete
	}

# } else if $hyperscaler == "aws" {

# 	COUNTER=$(kubectl get managed --no-headers | grep -v database | wc -l)

#     while [ $COUNTER -ne 0 ]; do
#         sleep 10
# 		echo "Waiting for $COUNTER resources to be deleted"
#         COUNTER=$(kubectl get managed --no-headers | grep -v database | wc -l)
#     done

# 	set +e
# 	helm --namespace kube-system delete cilium
# 	set -e

# 	eksctl delete addon --name aws-ebs-csi-driver --cluster dot-production --region us-east-1

# 	eksctl delete nodegroup --name primary --cluster dot-production --drain=false --region us-east-1 --wait

# 	eksctl delete cluster --config-file eksctl/config-cilium.yaml --wait

# } else {

# 	az group delete --name $RESOURCE_GROUP --yes

# 	az group delete --name cncf-demo-db --yes

}
