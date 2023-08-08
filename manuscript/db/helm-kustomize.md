# Setup PostgreSQL DB In The Dev Environment With Helm And Kustomize

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

yq --inplace ".patchesStrategicMerge = []" \
    kustomize/overlays/dev/kustomization.yaml

yq --inplace ".patchesStrategicMerge += \"deployment-postgresql.yaml\"" \
    kustomize/overlays/dev/kustomization.yaml

cat kustomize/overlays/dev/kustomization.yaml

kubectl --namespace dev kustomize --enable-helm \
    kustomize/overlays/dev \
    | kubectl --namespace dev apply --filename -

curl "https://cncf-demo-dev.$DOMAIN/videos"

# Proceed further ONLY if the output contains
#   `relation "videos" does not exist`.
```

## Continue The Adventure

* [Manage DB Schema](../db-schema/README.md)
