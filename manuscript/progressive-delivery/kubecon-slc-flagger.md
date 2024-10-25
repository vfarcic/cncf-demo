# Progressive Delivery with Argo Rollouts and Istio

TODO: Intro

## Setup

```sh
./manuscript/progressive-delivery/flagger.sh istio
```

```sh
kubectl --namespace production delete pods \
    --selector app.kubernetes.io/name=cncf-demo

kubectl --namespace production get pods
```

> Confirm that three containers (main and two sidecars) are in the cncf-demo Pod. 

## Do

> Execute the commands in this section only if you chose Argo Rollouts.

```sh
cat argo-rollouts/istio.yaml

cp argo-rollouts/istio.yaml infra/argo-rollouts-analysis.yaml

git add .

git commit -m "Analysis"

git push

kubectl get clusteranalysistemplates
```

* Wait until the resource was created

## How Did You Define Your App?

* [Kustomize](kustomize.md)
* [Helm](helm.md)
* [Carvel ytt](carvel.md)
* **cdk8s** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
