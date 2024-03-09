# Create and Manage Production AWS EKS Cluster with ClusterAPI

## Do

```bash
clusterctl generate cluster production \
    --flavor eks-managedmachinepool-vpccni \
    --kubernetes-version v1.29.0 --worker-machine-count 1 \
    --target-namespace production

cat capi/aws-eks.yaml

kubectl apply --filename capi/aws-eks.yaml

kubectl --namespace production get \
    clusters,awsmanagedclusters,awsmanagedcontrolplanes,machinepools,awsmanagedmachinepools

./capi/get-kubeconfig-aws.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

kubectl get nodes

kubectl create namespace production
```

## What Is Your Choice?

* [Flux](../gitops/rejekts-paris-flux.md)
* [Argo CD](../gitops/rejekts-paris-argocd.md)
* [Carvel kapp-controller](../gitops/rejekts-paris-kapp.md) (pending)
