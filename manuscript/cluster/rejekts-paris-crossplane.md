# Create and Manage Production AWS EKS Cluster with Crossplane

## Do

```bash
cat crossplane/aws-eks-small.yaml

kubectl --namespace production apply \
    --filename crossplane/aws-eks-small.yaml

kubectl --namespace production get clusterclaims

crossplane beta trace clusterclaim production \
    --namespace production

aws eks update-kubeconfig --region us-east-1 \
    --name production --kubeconfig kubeconfig-prod.yaml

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

kubectl get nodes
```

## What Is Your Choice?

* [Flux](../gitops/rejekts-paris-flux.md)
* [Argo CD](../gitops/rejekts-paris-argocd.md)
* [Carvel kapp-controller](../gitops/rejekts-paris-kapp.md) (pending)
