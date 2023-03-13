# Setup PostgreSQL DB In The Production Environment With Crossplane And cdk8s

TODO: Intro

## Setup

```bash
export DOMAIN=$(yq ".production.domain" settings.yaml)
```

## Do

```bash
cd cdk8s

cat db.go

cat app.go

export ENVIRONMENT=prod

cat app-prod.yaml

yq --inplace ".db.enabled.crossplane.$XP_DESTINATION = true" \
    app-prod.yaml

yq --inplace ".db.id = \"cncf-demo-db\"" app-prod.yaml

yq --inplace ".db.insecure = true" app-prod.yaml

yq --inplace ".schemahero.enabled = true" app-prod.yaml

cat app-prod.yaml

cdk8s synth --output ../yaml/prod --validate 

cd ..

cat yaml/prod/cncf-demo.k8s.yaml

git add .

git commit -m "App DB"

git push

# TODO: Remove
# If Azure
# kubectl get resourcegroup.azure.upbound.io,database.postgresql.sql.crossplane.io,firewallrule.dbforpostgresql.azure.upbound.io,server.dbforpostgresql.azure.upbound.io
# If AWS
# kubectl get vpc.ec2.aws.upbound.io,subnet.ec2.aws.upbound.io,subnetgroup.rds.aws.upbound.io,internetgateway.ec2.aws.upbound.io,routetable.ec2.aws.upbound.io,route.ec2.aws.upbound.io,mainroutetableassociation.ec2.aws.upbound.io,routetableassociation.ec2.aws.upbound.io,securitygroup.ec2.aws.upbound.io,securitygrouprule.ec2.aws.upbound.io,instance.rds.aws.upbound.io,database.postgresql.sql.crossplane.io,object.kubernetes.crossplane.io

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
