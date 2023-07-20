# Create And Manage Production AWS EKS Cluster With ClusterAPI

TODO: Intro

## Setup
To begin you must install the following:
1. [clusterawsadm CLI](https://cluster-api-aws.sigs.k8s.io/topics/using-clusterawsadm-to-fulfill-prerequisites.html#using-clusterawsadm-to-fulfill-prerequisites)

```bash
# Replace `[...]` with your desired region
export AWS_REGION=[...]

# Replace `[...]` with your access key ID`
export AWS_ACCESS_KEY_ID=[...]

# Replace `[...]` with your secret access key
export AWS_SECRET_ACCESS_KEY=[...]

# Create IAM Resources in AWS account
clusterawsadm bootstrap iam create-cloudformation-stack --config capi-config/capa-iam-config.yaml

# Create SSH Key pair

## If you want to create a new key pair run:
aws ec2 create-key-pair --key-name default --output json | jq .KeyMaterial -r

## To use an existing public key and import to AWS run
## NOTE: Only RSA keys are supported by AWS.
aws ec2 import-key-pair --key-name default --public-key-material "$(cat ~/.ssh/id_rsa.pub)"


# Export Environment Variables
export CLUSTER_TOPOLOGY=true
export EXP_CLUSTER_RESOURCE_SET=true
export EXP_MACHINE_POOL=true
export CAPA_EKS_IAM=true
export CAPA_EKS_ADD_ROLES=true
export EXP_EKS_FARGATE=true

# Install ClusterAPI Provider for AWS
clusterctl init --infrastructure aws

yq --inplace ".capi.destination = \"aws\"" settings.yaml
```

## Do

```bash
# Set values
# Replace `[...]` with your desired region
export AWS_REGION=`[...]`

# Set the SSH Key pair name as created above
export AWS_SSH_KEY_NAME=default
# Select worker node instance types
export AWS_NODE_MACHINE_TYPE=t3.large

# Generate cluster manifest
clusterctl generate cluster production --flavor eks-managedmachinepool-vpccni --kubernetes-version v1.24.1 --worker-machine-count=3 > capi/aws-eks.yaml

# Create the cluster
kubectl --namespace production apply --filename capi/aws-eks.yaml

kubectl --namespace production get Cluster
kubectl --namespace production get AWSManagedCluster
kubectl --namespace production get AWSManagedControlPlane
kubectl --namespace production get MachinePool
kubectl --namespace production get AWSManagedMachinePool

cat capi/get-kubeconfig-aws.sh

chmod +x capi/get-kubeconfig-aws.sh

./capi/get-kubeconfig-aws.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

yq --inplace \
    ".production.kubeConfig = \"$PWD/kubeconfig-prod.yaml\"" \
    settings.yaml

kubectl get nodes
```

## Continue The Adventure

The Adventure will continue soon...
