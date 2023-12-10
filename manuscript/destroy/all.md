# Destroy

Depending on the paths you took, some resources might not exist and, as a result, the commands that follow might throw an error. Feel free to ignore those.

## Google Cloud

Execute the commands in this section only if you used Google Cloud.

If you created the dev/management cluster yourself (e.g., a local Rancher Desktop cluster) instead of following the instructions in the `Development` section, **destroy the cluster** first. Otherwise, the commands that follow might be undone by Crossplane discovering drifts and recreating deleted resources.

```bash
export PROJECT_ID=$(yq ".google.projectId" settings.yaml)

gcloud projects delete $PROJECT_ID --quiet

export PROJECT_ID=$(\
    yq ".production.google.projectId" settings.yaml)

gcloud projects delete $PROJECT_ID --quiet
```

## Azure

Execute the commands in this section only if you used Azure.

If you created the dev/management cluster yourself (e.g., a local Rancher Desktop cluster) instead of following the instructions in the `Development` section, **destroy the cluster** first. Otherwise, the commands that follow might be undone by Crossplane discovering drifts and recreating deleted resources.

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
rm -rf infra/*.yaml

rm -rf apps/*.yaml

git add .

git commit -m "Destroy everything"

git push

kubectl --namespace production delete sqlclaim cncf-demo

# If using Contour
kubectl --namespace projectcontour delete service contour-envoy

# TODO: Remove NGINX
# TODO: Remove Emissary

kubectl get managed

# Wait until all the resources are removed

unset KUBECONFIG

# Execute the command that follows only if you created a
#   development cluster following the instructions in the
#   `Development` section.
export KUBECONFIG=$PWD/kubeconfig-dev.yaml

kubectl --namespace dev delete sqlclaim cncf-demo

kubectl --namespace production delete clusterclaim production

kubectl get managed

# Wait until all the resources are removed (excluding `database`)

helm delete harbor --namespace harbor

eksctl delete addon --name aws-ebs-csi-driver --cluster dot

eksctl delete cluster --config-file eksctl/config-cilium.yaml
```

If you created the dev/management cluster yourself (e.g., a local Rancher Desktop cluster) instead of following the instructions in the `Development` section, **destroy or reset the cluster**.
