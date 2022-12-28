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

az group delete --name production --yes
```

## AWS

Execute the commands in this section only if you used AWS

```bash
# If Crossplane with AWS
kubectl --namespace dev delete sqlclaim cncf-demo

# If Crossplane with AWS
kubectl --namespace production delete clusterclaim production

# If Crossplane with AWS
kubectl get managed

# If Crossplane with AWS
# Wait until all the resources are removed
#   (ignore `database.postgresql.sql.crossplane.io`)

kubectl --namespace traefik delete service traefik

eksctl delete cluster --name dot --region us-east-1
```
