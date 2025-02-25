# Policies with Open Policy Agent (OPA) and Gatekeeper

TODO: Intro

## Do

```sh
kubectl apply \
    --filename policies/gatekeeper-template-idp-$API.yaml

kubectl apply \
    --filename policies/gatekeeper-constraint-idp-$API.yaml

cat policies/gatekeeper-template-idp-$API.yaml

cat policies/gatekeeper-constraint-idp-$API.yaml

kubectl --namespace production apply \
    --filename cncf-demo-app/apps/silly-demo.yaml
```

> Execute the command that follows only if you chose **KubeVela**.

```sh
yq --inplace ".spec.components[0].traits[0].type = \"scaler\"" \
    cncf-demo-app/apps/silly-demo.yaml
```

> Execute the command that follows only if you chose **Crossplane**.

```sh
yq --inplace ".spec.parameters.scaling.enabled = true" \
    cncf-demo-app/apps/silly-demo.yaml
```

```sh
kubectl --namespace production apply \
    --filename cncf-demo-app/apps/silly-demo.yaml
```

> Execute the command that follows only if you chose **KubeVela**.

```sh
yq --inplace ".spec.components[0].traits[0].properties.min = 2" \
    cncf-demo-app/apps/silly-demo.yaml
```

> Execute the command that follows only if you chose **Crossplane**.

```sh
yq --inplace ".spec.parameters.scaling.min = 2" \
    cncf-demo-app/apps/silly-demo.yaml
```

```sh
kubectl --namespace production apply \
    --filename cncf-demo-app/apps/silly-demo.yaml

cd cncf-demo-app

git add .

git commit -m "Policies"

git push

cd ..
```

> The policy we explored will NOT work with KubeVela beyond that simple example since all KubeVela resources are `kind` `Application` and it would be close to impossible to distinguish one from another (e.g., app vs. database), control which components are used, and quite a few other things. Therefore, we'll remove the policies we applied (unless someone contributes better ones).

> Execute the command that follows only if you chose KubeVela.

```sh
kubectl delete \
    --filename policies/gatekeeper-constraint-idp-kubevela.yaml

kubectl delete \
    --filename policies/gatekeeper-template-idp-kubevela.yaml
```

## Continue The Adventure

* [Argo CD](../gitops-idp/kubecon-london-argocd.md)
* [Flux](../gitops-idp/kubecon-london-flux.md)

