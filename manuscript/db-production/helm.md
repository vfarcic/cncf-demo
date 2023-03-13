# Setup PostgreSQL DB In The Production Environment With Crossplane And Helm

TODO: Intro

## Setup

```bash
export DOMAIN=$(yq ".production.domain" settings.yaml)

export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)
```

## Do

```bash
cat helm/app/templates/postgresql-crossplane.yaml

cat helm/app/templates/deployment.yaml

cat helm/app/templates/schemahero.yaml

# Execute the command that follows only if you are using Argo CD
export VALUES=$(\
    yq ".spec.source.helm.values" apps/cncf-demo.yaml \
    | yq ".db.enabled.crossplane.$XP_DESTINATION = true" \
    | yq ".db.id = \"cncf-demo-db\"" \
    | yq ".db.insecure = true" \
    | yq ".schemahero.enabled = true")

# Execute the command that follows only if you are using Argo CD
yq --inplace ".spec.source.helm.values = \"$VALUES\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Flux
yq --inplace ".spec.values.db.enabled.crossplane.$XP_DESTINATION = true" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Flux
yq --inplace \
    ".spec.values.db.id = \"cncf-demo-db\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Flux
yq --inplace \
    ".spec.values.schemahero.enabled = true" \
    apps/cncf-demo.yaml

git add .

git commit -m "App DB"

git push

# TODO: Remove
# If Azure
# kubectl get resourcegroup.azure.upbound.io,database.postgresql.sql.crossplane.io,firewallrule.dbforpostgresql.azure.upbound.io,server.dbforpostgresql.azure.upbound.io

kubectl get managed

kubectl --namespace production get claim

# Wait until it is `READY`

# If you chose to use `nip.io` instead of a "real" domain,
#   replace `https` with `http`.
curl "https://cncf-demo.$DOMAIN/videos"

# If you chose to use `nip.io` instead of a "real" domain,
#   replace `https` with `http`.
curl -X POST "https://cncf-demo.$DOMAIN/video?id=wNBG1-PSYmE&title=Kubernetes%20Policies%20And%20Governance%20-%20Ask%20Me%20Anything%20With%20Jim%20Bugwadia"

# If you chose to use `nip.io` instead of a "real" domain,
#   replace `https` with `http`.
curl -X POST "https://cncf-demo.$DOMAIN/video?id=VlBiLFaSi7Y&title=Scaleway%20-%20Everything%20We%20Expect%20From%20A%20Cloud%20Computing%20Service%3F"

# If you chose to use `nip.io` instead of a "real" domain,
#   replace `https` with `http`.
curl "https://cncf-demo.$DOMAIN/videos" | jq .
```

## Continue The Adventure

[Policies](../policies/README.md)
[Destroy Everything](../destroy-all.md)
