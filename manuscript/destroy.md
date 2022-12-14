# Destroy

```bash
# If using Crossplane with Google Cloud
gcloud projects delete $PROJECT_ID

# If using Crossplane with Google Cloud
gcloud projects delete $XP_PROJECT_ID

# If using Crossplane with AWS
kubectl --namespace dev delete sqlclaim cncf-demo

# If using Crossplane with AWS
kubectl get managed

# If using Crossplane with AWS
# Wait until all the resources are removed
#   (ignore `database.postgresql.sql.crossplane.io`)

# If using Crossplane with AWS
kubectl --namespace traefik delete service traefik

# If using Crossplane with AWS
eksctl delete cluster --name dot --region us-east-1
```
