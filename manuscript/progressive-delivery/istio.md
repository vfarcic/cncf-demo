# Progressive Delivery with Argo Rollouts and Istio

TODO: Intro

## Setup

> Watch https://youtu.be/WiFLtcBvGMU if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

> Please skip executing `devbox shell` if you are already inside the Shell from one of the previous episodes.

```sh
devbox shell
```

> Execute the command that follows only if you chose **Flagger**.

```sh
./manuscript/progressive-delivery/flagger.sh istio
```

## Do

> Execute the commands in this section only if you chose **Argo Rollouts**.

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
