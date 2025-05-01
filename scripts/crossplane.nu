#!/usr/bin/env nu

def "main apply crossplane" [
    --hyperscaler = none,   # Which hyperscaler to use. Available options are `none`, `google`, `aws`, and `azure`
    --app = false,          # Whether to apply DOT App Configuration
    --db = false,           # Whether to apply DOT SQL Configuration
    --github = false,       # Whether to apply DOT GitHub Configuration
    --github_user: string,  # GitHub user required for the DOT GitHub Configuration and optinal for the DOT App Configuration
    --github_token: string, # GitHub token required for the DOT GitHub Configuration and optinal for the DOT App Configuration
    --policies = false      # Whether to create Validating ADmission Policies
    --skip_login = false    # Whether to skip the login (only for Azure)
] {

    mut project_id = ""

    helm repo add crossplane https://charts.crossplane.io/stable

    (
        helm upgrade --install crossplane crossplane/crossplane
            --namespace crossplane-system --create-namespace
            --set args='{"--enable-usages"}'
            --wait
    )

    if $hyperscaler == "google" {

        if PROJECT_ID in $env {
            $project_id = $env.PROJECT_ID
        } else {

            gcloud auth login

            $project_id = $"dot-(date now | format date "%Y%m%d%H%M%S")"
            $env.PROJECT_ID = $project_id
            $"export PROJECT_ID=($project_id)\n" | save --append .env

            gcloud projects create $project_id

            start $"https://console.cloud.google.com/billing/enable?project=($project_id)"
    
            print $"
Select the (ansi yellow_bold)Billing account(ansi reset) and press the (ansi yellow_bold)SET ACCOUNT(ansi reset) button.
Press any key to continue.
"
            input

        }

        let sa_name = "devops-toolkit"

        let sa = $"($sa_name)@($project_id).iam.gserviceaccount.com"

        let project = $project_id
    
        do --ignore-errors {(
            gcloud iam service-accounts create $sa_name
                --project $project
        )}

        sleep 5sec

        print $project_id
        print $sa
    
        (
            gcloud projects add-iam-policy-binding
                --role roles/admin $project_id
                --member $"serviceAccount:($sa)"
        )
    
        (
            gcloud iam service-accounts keys
                create gcp-creds.json --project $project_id
                --iam-account $sa
        )
    
        (
            kubectl --namespace crossplane-system
                create secret generic gcp-creds
                --from-file creds=./gcp-creds.json
        )

    } else if $hyperscaler == "aws" {

        if AWS_ACCESS_KEY_ID not-in $env {
            $env.AWS_ACCESS_KEY_ID = input $"(ansi yellow_bold)Enter AWS Access Key ID: (ansi reset)"
        }
        $"export AWS_ACCESS_KEY_ID=($env.AWS_ACCESS_KEY_ID)\n"
            | save --append .env

        if AWS_SECRET_ACCESS_KEY not-in $env {
            $env.AWS_SECRET_ACCESS_KEY = input $"(ansi yellow_bold)Enter AWS Secret Access Key: (ansi reset)"
        }
        $"export AWS_SECRET_ACCESS_KEY=($env.AWS_SECRET_ACCESS_KEY)\n"
            | save --append .env

        $"[default]
aws_access_key_id = ($env.AWS_ACCESS_KEY_ID)
aws_secret_access_key = ($env.AWS_SECRET_ACCESS_KEY)
" | save aws-creds.conf --force

        (
            kubectl --namespace crossplane-system
                create secret generic aws-creds
                --from-file creds=./aws-creds.conf
        )

    } else if $hyperscaler == "azure" {

        mut azure_tenant = ""
        if AZURE_TENANT not-in $env {
            $azure_tenant = input $"(ansi yellow_bold)Enter Azure Tenant: (ansi reset)"
        } else {
            $azure_tenant = $env.AZURE_TENANT
        }
        $"export AZURE_TENANT=($azure_tenant)\n"
            | save --append .env
        
        if $skip_login == false {
            az login --tenant $azure_tenant
        }
    
        let subscription_id = (az account show --query id -o tsv)
    
        (
            az ad sp create-for-rbac --sdk-auth --role Owner
                --scopes $"/subscriptions/($subscription_id)"
                | save azure-creds.json --force
        )

        (
            kubectl --namespace crossplane-system
                create secret generic azure-creds
                --from-file creds=./azure-creds.json
        )

    }

    if $app {

        print $"(ansi yellow_bold)Applying `dot-application` Configuration...(ansi reset)"

        {
            apiVersion: "pkg.crossplane.io/v1"
            kind: "Configuration"
            metadata: { name: "crossplane-app" }
            spec: { package: "xpkg.upbound.io/devops-toolkit/dot-application:v0.7.41" }
        } | to yaml | kubectl apply --filename -

        if $policies {

            {
                apiVersion: "admissionregistration.k8s.io/v1"
                kind: "ValidatingAdmissionPolicy"
                metadata: { name: "dot-app" }
                spec: {
                    failurePolicy: "Fail"
                    matchConstraints: {
                        resourceRules: [{
                            apiGroups:   ["devopstoolkit.live"]
                            apiVersions: ["*"]
                            operations:  ["CREATE", "UPDATE"]
                            resources:   ["appclaims"]
                        }]
                    }
                    validations: [
                        {
                            expression: "has(object.spec.parameters.scaling) && has(object.spec.parameters.scaling.enabled) && object.spec.parameters.scaling.enabled"
                            message: "`spec.parameters.scaling.enabled` must be set to `true`."
                        }, {
                            expression: "has(object.spec.parameters.scaling) && object.spec.parameters.scaling.min > 1"
                            message: "`spec.parameters.scaling.min` must be greater than `1`."
                        }
                    ]
                }
            } | to yaml | kubectl apply --filename -

            {
                apiVersion: "admissionregistration.k8s.io/v1"
                kind: "ValidatingAdmissionPolicyBinding"
                metadata: { name: "dot-app" }
                spec: {
                    policyName: "dot-app"
                    validationActions: ["Deny"]
                    # matchResources: { namespaceSelector: { matchLabels: { "kubernetes.io/metadata.name": a-team } } }
                }
            } | to yaml | kubectl apply --filename -

        }

    }

    if $db {

        print $"(ansi yellow_bold)Applying `dot-sql` Configuration...(ansi reset)"

        if $hyperscaler == "google" {
            
            start $"https://console.cloud.google.com/marketplace/product/google/sqladmin.googleapis.com?project=($project_id)"
            
            print $"
(ansi green_bold)ENABLE(ansi reset) the API.
Press any key to continue.
"
            input

        }

        {
            apiVersion: "pkg.crossplane.io/v1"
            kind: "Configuration"
            metadata: { name: "crossplane-sql" }
            spec: { package: "xpkg.upbound.io/devops-toolkit/dot-sql:v1.0.14" }
        } | to yaml | kubectl apply --filename -

    }

    if $github {

        print $"(ansi yellow_bold)Applying `dot-github` Configuration...(ansi reset)"

        {
            apiVersion: "pkg.crossplane.io/v1"
            kind: "Configuration"
            metadata: { name: "devops-toolkit-dot-github" }
            spec: { package: "xpkg.upbound.io/devops-toolkit/dot-github:v0.0.57" }
        } | to yaml | kubectl apply --filename -

    }

    {
        apiVersion: "v1"
        kind: "ServiceAccount"
        metadata: {
            name: "crossplane-provider-helm"
            namespace: "crossplane-system"
        }
    } | to yaml | kubectl apply --filename -
    
    {
        apiVersion: "rbac.authorization.k8s.io/v1"
        kind: "ClusterRoleBinding"
        metadata: {  name: crossplane-provider-helm }
        subjects: [{
            kind: "ServiceAccount"
            name: "crossplane-provider-helm"
            namespace: "crossplane-system"
        }]
        roleRef: {
            kind: "ClusterRole"
            name: "cluster-admin"
            apiGroup: "rbac.authorization.k8s.io"
        }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "pkg.crossplane.io/v1alpha1"
        kind: "ControllerConfig"
        metadata: { name: "crossplane-provider-helm" }
        spec: { serviceAccountName: "crossplane-provider-helm" }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "pkg.crossplane.io/v1"
        kind: "Provider"
        metadata: { name: "crossplane-provider-helm" }
        spec: {
            package: "xpkg.upbound.io/crossplane-contrib/provider-helm:v0.19.0"
            controllerConfigRef: { name: "crossplane-provider-helm" }
        }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "v1"
        kind: "ServiceAccount"
        metadata: {
            name: "crossplane-provider-kubernetes"
            namespace: "crossplane-system"
        }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "rbac.authorization.k8s.io/v1"
        kind: "ClusterRoleBinding"
        metadata: { name: "crossplane-provider-kubernetes" }
        subjects: [{
            kind: "ServiceAccount"
            name: "crossplane-provider-kubernetes"
            namespace: "crossplane-system"
        }]
        roleRef: {
            kind: "ClusterRole"
            name: "cluster-admin"
            apiGroup: "rbac.authorization.k8s.io"
        }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "pkg.crossplane.io/v1alpha1"
        kind: "ControllerConfig"
        metadata: { name: "crossplane-provider-kubernetes" }
        spec: { serviceAccountName: "crossplane-provider-kubernetes" }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "pkg.crossplane.io/v1"
        kind: "Provider"
        metadata: { name: "crossplane-provider-kubernetes" }
        spec: {
            package: "xpkg.upbound.io/crossplane-contrib/provider-kubernetes:v0.15.0"
            controllerConfigRef: { name: "crossplane-provider-kubernetes" }
        }
    } | to yaml | kubectl apply --filename -

    wait crossplane

    {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "ProviderConfig"
        metadata: { name: "default" }
        spec: { credentials: { source: "InjectedIdentity" } }
    } | to yaml | kubectl apply --filename -

    if $db and $hyperscaler != "none" {

        (
            main apply providerconfig $hyperscaler
                --google_project_id $project_id
        )

    }

    if ($github_user | is-not-empty) and ($github_token | is-not-empty) {

        {
            apiVersion: v1,
            kind: Secret,
            metadata: {
                name: github,
                namespace: crossplane-system
            },
            type: Opaque,
            stringData: {
                credentials: $"{\"token\":\"($github_token)\",\"owner\":\"($github_user)\"}"
            }
        } | to yaml | kubectl apply --filename -

        if $app or $github {

            {
                apiVersion: "github.upbound.io/v1beta1",
                kind: ProviderConfig,
                metadata: {
                    name: default
                },
                spec: {
                    credentials: {
                        secretRef: {
                            key: credentials,
                            name: github,
                            namespace: crossplane-system,
                        },
                        source: Secret
                    }
                }
            } | to yaml | kubectl apply --filename -

        }

    }

}

def "main delete crossplane" [
    --kind: string,
    --name: string,
    --namespace: string
] {

    print $"Waiting for (ansi yellow_bold)Crossplane managed resources(ansi reset) to be removed...\n"

    if ($kind | is-not-empty) and ($name | is-not-empty) and ($namespace | is-not-empty) { 
        kubectl --namespace $namespace delete $kind $name
    }
    
    mut command = { kubectl get managed --output name }
    if ($name | is-not-empty) {
        $command = {
            (
                kubectl get managed --output name
                    --selector $"crossplane.io/claim-name=($name)"
            )
        }
    }

    mut resources = (do $command)
    mut counter = ($resources | wc -l | into int)

    while $counter > 0 {
        print $"($resources)\nWaiting for remaining (ansi yellow_bold)($counter)(ansi reset) managed resources to be (ansi yellow_bold)removed(ansi reset)...\n"
        sleep 10sec
        $resources = (do $command)
        $counter = ($resources | wc -l | into int)
    }

}

def "main apply providerconfig" [
    hyperscaler: string,
    --google_project_id: string,
] {

    if $hyperscaler == "google" {

        {
            apiVersion: "gcp.upbound.io/v1beta1"
            kind: "ProviderConfig"
            metadata: { name: "default" }
            spec: {
                projectID: $google_project_id
                credentials: {
                    source: "Secret"
                    secretRef: {
                        namespace: "crossplane-system"
                        name: "gcp-creds"
                        key: "creds"
                    }
                }
            }
        } | to yaml | kubectl apply --filename -

    } else if $hyperscaler == "aws" {

        {
            apiVersion: "aws.upbound.io/v1beta1"
            kind: "ProviderConfig"
            metadata: { name: default }
            spec: {
                credentials: {
                    source: Secret
                    secretRef: {
                        namespace: crossplane-system
                        name: aws-creds
                        key: creds
                    }
                }
            }
        } | to yaml | kubectl apply --filename -
    
    } else if $hyperscaler == "azure" {

        {
            apiVersion: "azure.upbound.io/v1beta1"
            kind: "ProviderConfig"
            metadata: { name: default }
            spec: {
                credentials: {
                    source: "Secret"
                    secretRef: {
                        namespace: "crossplane-system"
                        name: "azure-creds"
                        key: "creds"
                    }
                }
            }
        } | to yaml | kubectl apply --filename -

    }

}

def "wait crossplane" [] {

    print $"(ansi yellow_bold)Waiting for Crossplane providers to be deployed...(ansi reset)"

    sleep 60sec

    (
        kubectl wait
            --for=condition=healthy provider.pkg.crossplane.io
            --all --timeout 30m
    )

}

