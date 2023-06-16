# Create And Manage Production AWS EKS Cluster With Crossplane

TODO: Intro

## Setup

* You can skip the steps in this section (the Setup) if you already used Crossplane with AWS in one of the previous chapters.

```bash
# Replace `[...]` with your access key ID`
export AWS_ACCESS_KEY_ID=[...]

# Replace `[...]` with your secret access key
export AWS_SECRET_ACCESS_KEY=[...]

echo "[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
" >aws-creds.conf

kubectl --namespace crossplane-system \
    create secret generic aws-creds \
    --from-file creds=./aws-creds.conf

kubectl get pkgrev

# Wait until all the packages are healthy

kubectl apply \
    --filename crossplane-config/provider-config-aws-official.yaml

yq --inplace ".crossplane.destination = \"aws\"" settings.yaml
```

## Do

```bash
cat crossplane/aws-eks.yaml

kubectl --namespace production apply \
    --filename crossplane/aws-eks.yaml

# TODO: Remove
# kubectl get clusters.eks.aws.upbound.io,clusterauths.eks.aws.upbound.io,nodegroups.eks.aws.upbound.io,roles.iam.aws.upbound.io,rolepolicyattachments.iam.aws.upbound.io,vpcs.ec2.aws.upbound.io,securitygroups.ec2.aws.upbound.io,securitygrouprules.ec2.aws.upbound.io,subnets.ec2.aws.upbound.io,internetgateways.ec2.aws.upbound.io,routetables.ec2.aws.upbound.io,routes.ec2.aws.upbound.io,mainroutetableassociations.ec2.aws.upbound.io,routetableassociations.ec2.aws.upbound.io,releases.helm.crossplane.io,objects.kubernetes.crossplane.io

kubectl get managed

kubectl --namespace production get claim

cat crossplane/get-kubeconfig-aws.sh

chmod +x crossplane/get-kubeconfig-aws.sh

./crossplane/get-kubeconfig-aws.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

yq --inplace \
    ".production.kubeConfig = \"$PWD/kubeconfig-prod.yaml\"" \
    settings.yaml

kubectl get nodes
```

## Continue The Adventure

[GitOps](../gitops/README.md)
