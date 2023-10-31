# Create and Manage Production AWS EKS Cluster with ClusterAPI

## Do

```bash
clusterctl generate cluster production \
    --flavor eks-managedmachinepool-vpccni \
    --kubernetes-version v1.28.1 --worker-machine-count 3 \
    --target-namespace production \
    | tee capi/aws-eks.yaml

kubectl apply --filename capi/aws-eks.yaml

kubectl --namespace production get \
    clusters,awsmanagedclusters,awsmanagedcontrolplanes,machinepools,awsmanagedmachinepools

./capi/get-kubeconfig-aws.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

kubectl get nodes

kubectl create namespace production
```

## Continue the adventure

* [Flux](../gitops/kubecon-flux.md)
* [Argo CD](../gitops/kubecon-argocd.md)
* [Carvel kapp-controller](../gitops/kubecon-kapp.md)
