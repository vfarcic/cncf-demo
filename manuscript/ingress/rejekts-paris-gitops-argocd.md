# Ingress For Argo CD

## Do

```bash
cat argocd/helm-values.yaml

yq --inplace ".server.ingress.enabled = true" \
    argocd/helm-values.yaml

yq --inplace \
    ".server.ingress.ingressClassName = \"$INGRESS_CLASS_NAME\"" \
    argocd/helm-values.yaml

yq --inplace ".server.ingress.hostname = \"gitops.$DOMAIN\"" \
    argocd/helm-values.yaml

cat argocd/helm-values.yaml

helm upgrade --install argocd argo-cd \
    --repo https://argoproj.github.io/argo-helm \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

open "http://gitops.$DOMAIN"

# Login with the following credentials:
# - Username: admin
# - Password: admin123
```

## How Did You Define Your App?

* [Helm](../app/rejekts-paris-helm.md)
* [Kustomize](../app/rejekts-paris-kustomize.md)
* [Carvel ytt](../app/rejekts-paris-carvel.md) (pending)
* [cdk8s](../app/rejekts-paris-cdk8s.md) (pending)
