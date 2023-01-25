# Setup PostgreSQL DB In The Production Environment With Crossplane

TODO: Intro

## Setup

```bash
export XP_DESTINATION=$(\
    yq ".crossplane.destination" settings.yaml)

cat crossplane/create-secret-$XP_DESTINATION.sh

chmod +x crossplane/create-secret-$XP_DESTINATION.sh

./crossplane/create-secret-$XP_DESTINATION.sh
```

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel](carvel.md)
* [cdk8s](cdk8s.md)


```bash
# TODO: Move to apps

cat crossplane/cncf-demo-db-$XP_DESTINATION.yaml

cp crossplane/cncf-demo-db-$XP_DESTINATION.yaml \
    apps/cncf-demo-db.yaml

git add .

git commit -m "App DB"

git push

# TODO: Remove
# kubectl get resourcegroup.azure.upbound.io,database.postgresql.sql.crossplane.io,firewallrule.dbforpostgresql.azure.upbound.io,server.dbforpostgresql.azure.upbound.io

kubectl get managed

kubectl --namespace production get claim

# Wait until it is `READY`

export DOMAIN=$(yq ".production.domain" settings.yaml)

curl "https://cncf-demo.$DOMAIN/videos"

# TODO: Add SchemaHero
```