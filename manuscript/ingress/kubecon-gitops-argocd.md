# Ingress For Argo CD

TODO: Intro

## Setup

```bash
./manuscript/ingress/gitops-argocd.sh

source .env
```

## Do

```bash
cat argocd/helm-values.yaml

yq --inplace ".server.ingress.enabled = true" \
    argocd/helm-values.yaml

yq --inplace \
    ".server.ingress.ingressClassName = \"$INGRESS_CLASS_NAME\"" \
    argocd/helm-values.yaml

yq --inplace ".server.ingress.hosts[0] = \"gitops.$DOMAIN\"" \
    argocd/helm-values.yaml

cat argocd/helm-values.yaml

helm upgrade --install argocd argo/argo-cd \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

echo "http://gitops.$DOMAIN"

# Open it in a browser

# Login with the following credentials:
# - Username: admin
# - Password: admin123
```

## Continue The Adventure

* [Helm](../app/kubecon-helm.md)
* [Kustomize](../app/kubecon-kustomize.md)
* [Carvel ytt](../app/kubecon-carvel.md)
* [cdk8s](../app/kubecon-cdk8s.md)
