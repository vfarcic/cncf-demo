# Setup PostgreSQL DB In The Dev Kubernetes With Crossplane

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
cat helm/app/templates/postgresql-crossplane-local.yaml

cat helm/app/templates/deployment.yaml

cat helm/app/values.yaml

yq --inplace ".db.enabled.crossplaneLocal = true" helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait

# TODO: Fix the status
kubectl --namespace dev get sqlclaims

helm --namespace dev ls

curl "https://dev.cncf-demo.$DOMAIN/videos"
```

## Continue The Adventure

[Manage DB Schema](../db-schema/story.md)

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
yq --inplace ".db.enabled.crossplaneLocal = false" \
    helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait
```
