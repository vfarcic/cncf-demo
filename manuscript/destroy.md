# Destroy

```bash
export KUBECONFIG=$PWD/kubeconfig-dev.yaml

# If Google Cloud
gcloud projects delete $PROJECT_ID --quiet

# If Google Cloud
gcloud projects delete $XP_PROJECT_ID --quiet

# If Azure
az group delete --name $RESOURCE_GROUP --yes

# If Azure
az group delete --name $XP_RESOURCE_GROUP --yes

# If Crossplane with AWS
kubectl --namespace dev delete sqlclaim cncf-demo

# If Crossplane with AWS
kubectl --namespace production delete clusterclaim production

# If AWS
kubectl get managed

# If Crossplane with AWS
# Wait until all the resources are removed
#   (ignore `database.postgresql.sql.crossplane.io`)

# If AWS
kubectl --namespace traefik delete service traefik

# If AWS
eksctl delete cluster --name dot --region us-east-1
```
