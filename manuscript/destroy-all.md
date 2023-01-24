# Destroy

Depending on the paths you took, some resources might not exist and, as a result, the commands that follow might through an error. Feel free to ignore them.

## Google Cloud

Execute the commands in this section only if you used Google Cloud

```bash
export PROJECT_ID=$(yq ".google.projectId" settings.yaml)

gcloud projects delete $PROJECT_ID --quiet

export PROJECT_ID=$(\
    yq ".google.crossplane.projectId" settings.yaml)

gcloud projects delete $PROJECT_ID --quiet
```

## Azure

Execute the commands in this section only if you used Azure

```bash
export RESOURCE_GROUP=$(yq ".azure.resourceGroup" settings.yaml)

az group delete --name $RESOURCE_GROUP --yes

# If using Crossplane
az group delete --name cncf-demo-db-dev --yes

az group delete --name production --yes
```

## AWS

Execute the commands in this section only if you used AWS

```bash
# TODO: Remove Ingress service from the prod cluster

# If using Crossplane
kubectl --kubeconfig $PWD/kubeconfig-dev.yaml \
    --namespace dev delete sqlclaim cncf-demo

# If using Crossplane
kubectl --kubeconfig $PWD/kubeconfig-dev.yaml \
    --namespace production delete clusterclaim production

# If using Crossplane
kubectl --kubeconfig $PWD/kubeconfig-dev.yaml get managed

# If Crossplane with AWS
# Wait until all the resources are removed
#   (ignore `database.postgresql.sql.crossplane.io`)

eksctl delete cluster --name dot --region us-east-1
```
