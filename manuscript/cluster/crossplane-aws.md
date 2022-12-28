# Create And Manage Production AWS EKS Cluster With Crossplane

TODO: Intro

## Setup

* You can skip the steps in this section if you already used Crossplane with AWS in one of the previous chapters.

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

kubectl apply --filename crossplane-config/provider-aws.yaml

kubectl get pkgrev

# Wait until all the packages are healthy

kubectl apply \
    --filename crossplane-config/provider-config-aws.yaml
```

## Do

```bash
export XP_DESTINATION=aws

cat crossplane/aws-eks.yaml

kubectl --namespace production apply \
    --filename crossplane/aws-eks.yaml

kubectl get managed

kubectl --namespace production get clusterclaims

cat crossplane/get-kubeconfig-$XP_DESTINATION.sh

./crossplane/get-kubeconfig-$XP_DESTINATION.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

kubectl get nodes
```

## Continue The Adventure

[GitOps](../gitops/story.md)
