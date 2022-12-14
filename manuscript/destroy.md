# Destroy

```bash
# Destroy the management cluster

# If using Crossplane with Google Cloud
gcloud projects delete $XP_PROJECT_ID

# If using Crossplane with AWS
helm upgrade --install cncf-demo helm/app --namespace dev

# If using Crossplane with AWS
kubectl get managed

# If using Crossplane with AWS
# Wait until all the resources are removed
```
