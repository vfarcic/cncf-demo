# Destroy

```bash
export KUBECONFIG=$PWD/kubeconfig-dev.yaml
```

## Google Cloud

Execute the commands in this section only if you used Google Cloud

```bash
gcloud projects delete $PROJECT_ID --quiet

gcloud projects delete $XP_PROJECT_ID --quiet
```

## Azure

Execute the commands in this section only if you used Google Cloud

```bash
az group delete --name $RESOURCE_GROUP --yes

# If using Crossplane
az group delete --name cncf-demo-db-dev --yes

az group delete --name production --yes
```

## AWS

Execute the commands in this section only if you used AWS

```bash
kubectl --kubeconfig $PWD/kubeconfig-dev.yaml \
    --namespace traefik delete service traefik

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
