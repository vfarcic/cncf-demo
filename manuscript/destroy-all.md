# Destroy

Depending on the paths you took, some resources might not exist and, as a result, the commands that follow might through an error. Feel free to ignore those.

If you created the dev/management cluster yourself (e.g., a local Rancher Desktop cluster) instead of following the instructions in the `Development` section, **destroy the cluster** first. Otherwise, the commands that follow might be undone by Crossplane discovering drifs and recreating deleted resources.


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

az group delete --name cncf-demo-db-dev --yes

az group delete --name production --yes

az group delete --name cncf-demo-db --yes
```

## AWS

Execute the commands in this section only if you used AWS

```bash
# TODO: Remove Ingress service from the prod cluster

kubectl --kubeconfig $PWD/kubeconfig-dev.yaml \
    --namespace dev delete sqlclaim cncf-demo

kubectl --kubeconfig $PWD/kubeconfig-dev.yaml \
    --namespace production delete sqlclaim cncf-demo

kubectl --kubeconfig $PWD/kubeconfig-dev.yaml \
    --namespace production delete clusterclaim production

kubectl --kubeconfig $PWD/kubeconfig-dev.yaml get managed

# Wait until all the resources are removed
#   (ignore `database.postgresql.sql.crossplane.io`)

eksctl delete cluster --name dot --region us-east-1
```
