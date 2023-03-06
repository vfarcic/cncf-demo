# Setup PostgreSQL DB In The Dev Kubernetes With Crossplane And cdk8s

TODO: Intro

## Do

```bash
cd cdk8s

cat crossplane.go

cat main.go

export ENVIRONMENT=dev

yq --inplace ".db.enabled.crossplane.$XP_DESTINATION = true" \
    app-dev.yaml

yq --inplace ".db.insecure = true" app-dev.yaml

cdk8s synth --output ../yaml/dev --validate 

cd ..

cat yaml/dev/cncf-demo.k8s.yaml

kubectl --namespace dev apply --filename yaml/dev

# TODO: Remove
# If AWS
# kubectl get subnet.ec2.aws.crossplane.io,internetgateway.ec2.aws.crossplane.io,routetable.ec2.aws.crossplane.io,vpc.ec2.aws.crossplane.io,securitygroup.ec2.aws.crossplane.io,database.postgresql.sql.crossplane.io,rdsinstance.database.aws.crossplane.io,dbsubnetgroup.database.aws.crossplane.io

# TODO: Remove
# If Google Cloud
# kubectl get object.kubernetes.crossplane.io,database.postgresql.sql.crossplane.io,user.sql.gcp.upbound.io,databaseinstance.sql.gcp.upbound.io

kubectl get managed

kubectl --namespace dev get sqlclaims

# Wait until it is `READY`

curl "https://cncf-demo-dev.$DOMAIN/videos"

# Proceed further ONLY if the output contains
#   `relation "videos" does not exist`.
```

## Continue The Adventure

[Manage DB Schema](../db-schema/README.md)
