# State Synchronization (GitOps) with Flux

## Do

```sh
kubectl --namespace production delete \
    --filename cncf-demo-app/apps/silly-demo.yaml

cat flux/apps-idp.yaml

kubectl --namespace production get all,ingresses

kubectl apply --filename flux/apps-idp.yaml

kubectl --namespace production get all,ingresses
```

> The Pod `STATUS` is still `ErrImagePull` or `ImagePullBackOff` because there is no image. We'll fix that later.

## Continue The Adventure

## What Is Your Choice?

* [Argo Workflows](../workflows/kubecon-london-argo-workflows.md)
