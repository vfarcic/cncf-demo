# Destroy

```bash
rm -rf infra/*.yaml

git add .

git commit -m "Destroy"

git push

kubectl get services --all-namespaces

# Wait until all the services with External IP are removed

export KUBECONFIG=$PWD/kubeconfig.yaml

kubectl --namespace production delete \
    --filename crossplane/aws-eks-small.yaml

COUNTER=$(kubectl get managed --no-headers | grep -v object | grep -v release | wc -l)

while [ $COUNTER -ne 0 ]; do
    sleep 10
    echo "Waiting for $COUNTER resources to be deleted"
    COUNTER=$(kubectl get managed --no-headers | grep -v object | grep -v release | wc -l)
done

kubectl delete --filename capi/aws-eks.yaml

clusterawsadm bootstrap iam delete-cloudformation-stack --config capi-config/capa-iam-config.yaml

eksctl delete cluster --config-file eksctl/config-small.yaml
```