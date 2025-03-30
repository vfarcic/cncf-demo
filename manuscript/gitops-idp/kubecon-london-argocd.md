# State Synchronization (GitOps) with Argo CD

## Do

```sh
kubectl --namespace production delete \
    --filename cncf-demo-app/apps/silly-demo.yaml

open "http://argocd.$INGRESS_HOST"
```

> Open the URL from the output of the previous command in a browser.
> User `admin` as the `Username` and `admin123` as the `Password`.

```sh
cat argocd/apps-idp.yaml

kubectl --namespace production get all,ingresses

kubectl apply --filename argocd/apps-idp.yaml

kubectl --namespace production get all,ingresses
```

> The Pod `STATUS` is still `ErrImagePull` or `ImagePullBackOff` because there is no image. We'll fix that later.

## Continue The Adventure

* [Argo Workflows](../workflows/kubecon-london-argo-workflows.md)
