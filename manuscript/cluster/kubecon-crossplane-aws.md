# Create and Manage Production AWS EKS Cluster with Crossplane

## Do

```bash
cat crossplane/aws-eks.yaml

kubectl --namespace production apply \
    --filename crossplane/aws-eks.yaml

kubectl get managed

kubectl --namespace production get clusterclaims

./crossplane/get-kubeconfig-aws.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

kubectl get nodes
```

## Continue the adventure

* [Flux](../gitops/kubecon-flux.md)
* [Argo CD](../gitops/kubecon-argocd.md)
* [Carvel kapp-controller](../gitops/kubecon-kapp.md)
