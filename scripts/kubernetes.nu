#!/usr/bin/env nu

def --env "main create kubernetes" [provider: string, name = "dot", min_nodes = 2, max_nodes = 4, auth = true] {

    $env.KUBECONFIG = $"($env.PWD)/kubeconfig-($name).yaml"
    $"export KUBECONFIG=($env.KUBECONFIG)\n" | save --append .env

    if $provider == "google" {

        if $auth {
            gcloud auth login
        }

        mut project_id = ""
        if PROJECT_ID in $env and not $auth {
            $project_id = $env.PROJECT_ID
        } else {
            $project_id = $"dot-(date now | format date "%Y%m%d%H%M%S")"
            $env.PROJECT_ID = $project_id
            $"export PROJECT_ID=($project_id)\n" | save --append .env

            gcloud projects create $project_id

            start $"https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=($project_id)"
    
            print $"(ansi yellow_bold)
ENABLE(ansi reset) the API.
Press any key to continue.
"
            input
        }

        (
            gcloud container clusters create $name --project $project_id
                --zone us-east1-b --machine-type e2-standard-8
                --enable-autoscaling --num-nodes $min_nodes
                --min-nodes $min_nodes --max-nodes $max_nodes
                --enable-network-policy --no-enable-autoupgrade
        )

        (
            gcloud container clusters get-credentials $name
                --project $project_id --zone us-east1-b
        )

    } else if $provider == "aws" {

        mut aws_access_key_id = ""
        if AWS_ACCESS_KEY_ID in $env {
            $aws_access_key_id = $env.AWS_ACCESS_KEY_ID
        } else {
            $aws_access_key_id = input $"(ansi green_bold)Enter AWS Access Key ID: (ansi reset)"
        }
        $"export AWS_ACCESS_KEY_ID=($aws_access_key_id)\n"
            | save --append .env

        mut aws_secret_access_key = ""
        if AWS_SECRET_ACCESS_KEY in $env {
            $aws_secret_access_key = $env.AWS_SECRET_ACCESS_KEY
        } else {
            $aws_secret_access_key = input $"(ansi green_bold)Enter AWS Secret Access Key: (ansi reset)" --suppress-output
        }
        $"export AWS_SECRET_ACCESS_KEY=($aws_secret_access_key)\n"
            | save --append .env
    
        mut aws_account_id = ""
        if AWS_ACCOUNT_ID in $env {
            $aws_account_id = $env.AWS_ACCOUNT_ID
        } else {
            $aws_account_id = input $"(ansi green_bold)Enter AWS Account ID: (ansi reset)"
        }
        $"export AWS_ACCOUNT_ID=($aws_account_id)\n"
            | save --append .env
    
        $"[default]
aws_access_key_id = ($aws_access_key_id)
aws_secret_access_key = ($aws_secret_access_key)
" | save aws-creds.conf --force

        {
            apiVersion: "eksctl.io/v1alpha5"
            kind: "ClusterConfig"
            metadata: {
                name: "dot"
                region: "us-east-1"
                version: "1.31"
            }
            managedNodeGroups: [{
                name: "primary"
                instanceType: "t3.large"
                minSize: 3
                maxSize: 6
                iam: {
                    withAddonPolicies: {
                        autoScaler: true
                        ebs: true
                    }
                }
            }]
        } | to yaml | save $"eksctl-config-($name).yaml" --force
    
        (
            eksctl create cluster
                --config-file $"eksctl-config-($name).yaml"
                --kubeconfig $env.KUBECONFIG
        )
    
        (
            eksctl create addon --name aws-ebs-csi-driver
                --cluster $name
                --service-account-role-arn $"arn:aws:iam::($aws_account_id):role/AmazonEKS_EBS_CSI_DriverRole"
                --region us-east-1 --force
        )

    } else if $provider == "azure" {

        mut tenant_id = ""
        let location = "eastus"

        if AZURE_TENANT in $env {
            $tenant_id = $env.AZURE_TENANT
        } else {
            $tenant_id = input $"(ansi green_bold)Enter Azure Tenant ID: (ansi reset)"
        }

        if $auth {
            az login --tenant $tenant_id
        }

        mut resource_group = ""
        if RESOURCE_GROUP in $env {
            $resource_group = $env.RESOURCE_GROUP
        } else {
            $resource_group = $"dot-(date now | format date "%Y%m%d%H%M%S")"
            $env.RESOURCE_GROUP = $resource_group
            $"export RESOURCE_GROUP=($resource_group)\n" | save --append .env
            az group create --name $resource_group --location $location
        }

        (
            az aks create --resource-group $resource_group --name $name
                --node-count $min_nodes --min-count $min_nodes
                --max-count $max_nodes
                --node-vm-size Standard_B4ms
                --enable-managed-identity --generate-ssh-keys
                --enable-cluster-autoscaler --yes
        )

        (
            az aks get-credentials --resource-group $resource_group
                --name $name --file $env.KUBECONFIG
        )

    } else if $provider == "kind" {

        kind create cluster --config kind.yaml
    
    } else {

        print $"(ansi red_bold)($provider)(ansi reset) is not a supported."
        exit 1

    }

    $env.KUBECONFIG

}

def "main destroy kubernetes" [provider: string, name = "dot", delete_project = true] {

    if $provider == "google" {

        rm --force kubeconfig.yaml

        (
            gcloud container clusters delete $name
                --project $env.PROJECT_ID --zone us-east1-b --quiet
        )

        if $delete_project {
            gcloud projects delete $env.PROJECT_ID --quiet
        }
    
    } else if $provider == "aws" {

        (
            eksctl delete addon --name aws-ebs-csi-driver
                --cluster $name --region us-east-1
        )

        (
            eksctl delete nodegroup --name primary
                --cluster $name --drain=false
                --region us-east-1 --parallel 10 --wait
        )

        (
            eksctl delete cluster
                --config-file $"eksctl-config-($name).yaml"
                --wait
        )

    } else if $provider == "azure" {

        az group delete --name $env.RESOURCE_GROUP --yes

    } else if $provider == "kind" {

        kind delete cluster

    }

    rm --force kubeconfig.yaml

}
