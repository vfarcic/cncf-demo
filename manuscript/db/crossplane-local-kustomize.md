# TODO: With TODO:

TODO: Intro

## Setup

```bash
helm repo add crossplane-stable \
    https://charts.crossplane.io/stable

helm repo update

helm upgrade --install \
    crossplane crossplane-stable/crossplane \
    --namespace crossplane-system \
    --create-namespace \
    --wait

kubectl apply \
    --filename https://raw.githubusercontent.com/vfarcic/devops-toolkit-crossplane/master/crossplane-config/provider-kubernetes-incluster.yaml

kubectl apply \
    --filename https://raw.githubusercontent.com/vfarcic/devops-toolkit-crossplane/master/crossplane-config/provider-helm-incluster.yaml

kubectl apply \
    --filename https://raw.githubusercontent.com/vfarcic/devops-toolkit-crossplane/master/crossplane-config/config-sql.yaml
```

## Do

```bash
cat kustomize/overlays/dev/postgresql-crossplane-local.yaml

yq --inplace ".resources += \"postgresql-crossplane-local.yaml\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/deployment-crossplane-postgresql.yaml

yq --inplace ".patchesStrategicMerge = []" \
    kustomize/overlays/dev/kustomization.yaml

yq --inplace ".patchesStrategicMerge += \"deployment-crossplane-postgresql.yaml\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/kustomization.yaml

kubectl --namespace dev apply --kustomize kustomize/overlays/dev

# TODO: Fix the status
kubectl --namespace dev get sqlclaims

curl "https://dev.cncf-demo.$DOMAIN/videos"
```

## Continue The Adventure

[Manage DB Schema](../db-schema/story.md)
