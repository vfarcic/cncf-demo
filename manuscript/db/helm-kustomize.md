# Setup PostgreSQL DB In The Dev Environment With Helm

TODO: Intro

## Do

```bash
cat kustomize/overlays/dev/kustomization.yaml

yq --inplace ".helmCharts[0].name = \"postgresql\"" \
    kustomize/overlays/dev/kustomization.yaml

yq --inplace ".helmCharts[0].releaseName = \"postgresql\"" \
    kustomize/overlays/dev/kustomization.yaml

yq --inplace ".helmCharts[0].repo = \"https://charts.bitnami.com/bitnami\"" \
    kustomize/overlays/dev/kustomization.yaml

yq --inplace ".helmCharts[0].version = \"12.1.2\"" \
    kustomize/overlays/dev/kustomization.yaml

yq --inplace ".helmCharts[0].namespace = \"dev\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/postgresql-values.yaml

yq --inplace ".helmCharts[0].valuesFile = \"postgresql-values.yaml\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/deployment-postgresql.yaml

yq --inplace ".patchesStrategicMerge += \"deployment-postgresql.yaml\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/kustomization.yaml

kubectl kustomize --enable-helm kustomize/overlays/dev \
    | kubectl apply --filename -

curl "https://dev.cncf-demo.$DOMAIN/videos"
```

## Continue The Adventure

[Manage DB Schema](../db-schema/story.md)

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
yq --inplace \
    "del(.patchesStrategicMerge[] | select(. == \"deployment-postgresql.yaml\"))" \
    kustomize/overlays/dev/kustomization.yaml

yq --inplace \
    "del(.helmCharts[] | select(.name == \"postgresql\"))" \
    kustomize/overlays/dev/kustomization.yaml

kubectl kustomize --namespace dev --enable-helm kustomize/overlays/dev \
    | kubectl apply --filename -

# TODO: Delete DB resources
```
