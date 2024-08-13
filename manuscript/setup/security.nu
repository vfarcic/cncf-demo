#!/usr/bin/env nu

rm .env

source common.nu

start-script

header "Hyperscalers"

let hyperscaler = get-hyperscaler

$env.KUBECONFIG = $"($env.PWD)/kubeconfig.yaml"
$"export KUBECONFIG=($env.KUBECONFIG)\n" | save --append .env

helm repo add cilium https://helm.cilium.io
helm repo update

if $hyperscaler == "google" {

    let project_id = $"dot-(date now | format date "%Y%m%d%H%M%S")"
    $"export PROJECT_ID=($project_id)\n" | save --append .env

    open settings.yaml
        | upsert production.google.projectId $project_id
        | save settings.yaml --force

    gcloud projects create $project_id

    start $"https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=($project_id)"

    print $"(ansi yellow_bold)
    ENABLE(ansi reset) the API.
    Press any key to continue.
    "
    input

    start $"https://console.cloud.google.com/apis/library/sqladmin.googleapis.com?project=($project_id)"
    print $"(ansi yellow_bold)
    ENABLE(ansi reset) the API.
    Press any key to continue.
    "
    input

    (
        gcloud container clusters create dot --project $project_id
            --zone us-east1-b --machine-type e2-standard-8
            --enable-autoscaling --num-nodes 1 --min-nodes 1
            --max-nodes 3 --enable-network-policy
            --node-taints node.cilium.io/agent-not-ready=true:NoExecute
            --no-enable-autoupgrade
    )

    (
        gcloud container clusters get-credentials dot
            --project $project_id --zone us-east1-b
    )

    let clusterIpv4Cidr = (
        gcloud container clusters describe dot
            --zone us-east1-b --project $project_id
    ) | from yaml | get "clusterIpv4Cidr"
    
    (
        helm upgrade --install cilium cilium/cilium
            --version "1.14.4" --namespace kube-system
            --set nodeinit.enabled=true
            --set nodeinit.reconfigureKubelet=true
            --set nodeinit.removeCbrBridge=true
            --set cni.binPath=/home/kubernetes/bin
            --set gke.enabled=true --set ipam.mode=kubernetes
            --set ipv4NativeRoutingCIDR=($clusterIpv4Cidr) --wait
    )

    let sa_name = "devops-toolkit"

    let sa = $"($sa_name)@($project_id).iam.gserviceaccount.com"

    (
        gcloud iam service-accounts create $sa_name 
            --project $project_id
    )

    (
        gcloud projects add-iam-policy-binding
            --role roles/admin $project_id
            --member $"serviceAccount:($sa)"
    )

    (
        gcloud iam service-accounts keys create gcp-creds.json
            --project $project_id --iam-account $sa
    )

} else if $hyperscaler == "aws" {

    let aws_access_key_id = input $"(ansi green_bold)Enter AWS Access Key ID: (ansi reset)"
    $"export AWS_ACCESS_KEY_ID=($aws_access_key_id)\n" | save --append .env

    let aws_secret_access_key = input $"(ansi green_bold)Enter AWS Secret Access Key: (ansi reset)" --suppress-output
    $"export AWS_SECRET_ACCESS_KEY=($aws_secret_access_key)\n" | save --append .env

    let aws_account_id = input $"(ansi green_bold)Enter AWS Account ID: (ansi reset)"
    $"export AWS_ACCOUNT_ID=($aws_account_id)\n" | save --append .env

    $"[default]
aws_access_key_id = ($aws_access_key_id)
aws_secret_access_key = ($aws_secret_access_key)
" | save aws-creds.conf --force

    (
        eksctl create cluster
            --config-file eksctl/config-cilium.yaml
            --kubeconfig kubeconfig.yaml
    )

    sleep 10sec

    (
        kubectl --namespace kube-system patch daemonset aws-node
            --type strategic
            --patch '{"spec":{"template":{"spec":{"nodeSelector":{"io.cilium/aws-node-enabled":"true"}}}}}'
    )

    (
        helm install cilium cilium/cilium
            --version "1.15.0" --namespace kube-system
            --set eni.enabled=true --set ipam.mode=eni
            --set routingMode=native
            --set egressMasqueradeInterfaces=eth0 --wait
    )

    (
        eksctl create addon --name aws-ebs-csi-driver
            --cluster dot-production
            --service-account-role-arn arn:aws:iam::$AWS_ACCOUNT_ID:role/AmazonEKS_EBS_CSI_DriverRole
            --region us-east-1 --force
    )

} else {

    az login

    let resource_group = $"dot-(date now | format date "%Y%m%d%H%M%S")"
    $"export RESOURCE_GROUP=($resource_group)\n" | save --append .env

    let location = "eastus"

    open settings.yaml
        | upsert production.azure.resourceGroup $resource_group
        | upsert production.azure.location $location
        | save settings.yaml --force

    az group create --name $resource_group --location $location

    (
        az aks create --resource-group $resource_group --name dot
            --node-count 3 --node-vm-size Standard_B2ms
            --enable-managed-identity --network-plugin none
            --generate-ssh-keys --yes
    )

    (
        az aks get-credentials --resource-group $resource_group
            --name dot --file $env.KUBECONFIG
    )

    (
        helm install cilium cilium/cilium --version "1.14.2"
            --namespace kube-system --set aksbyocni.enabled=true
            --set nodeinit.enabled=true --wait
    )

}

header "Setup GitOps"

kubectl create namespace production

let continue = [Yes No]
    | input list $"We are about to install Argo CD.
If you prefer a solution other than Argo CD for GitOps, please go back to the prod.md or an earlier chapter.
(ansi green_bold)Continue?(ansi reset)
"

if continue == No { exit }

let repo_url = git config --get remote.origin.url

open argocd/app-apps.yaml
    | upsert spec.source.repoURL $repo_url
    | save argocd/app-apps.yaml --force

open argocd/app-infra.yaml
    | upsert spec.source.repoURL $repo_url
    | save argocd/app-infra.yaml --force

(
    helm upgrade --install argocd argo-cd 
        --repo https://argoproj.github.io/argo-helm 
        --namespace argocd --create-namespace 
        --values argocd/helm-values.yaml --wait
)

kubectl apply --filename argocd/project.yaml

kubectl apply --filename argocd/app-apps.yaml

kubectl apply --filename argocd/app-infra.yaml

let gitops_app = "argocd"

$"export GITOPS_APP=($gitops_app)\n" | save --append .env

open settings.yaml
    | upsert gitOps.app $gitops_app
    | save settings.yaml --force

header "Setup Ingress"

cp $"($gitops_app)/contour.yaml" infra/.

git add . 

git commit -m "Contour"

git push

mut pods = 0; while $pods == 0 {
    print "Waiting for Contour to be deployed..."
    sleep 10sec
    $pods = ( kubectl --namespace projectcontour get pods
        | length )
}

sleep 10sec

if $hyperscaler == "aws" {

#     INGRESS_IPNAME=$(kubectl --namespace projectcontour get service contour-envoy --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

#     INGRESS_IP=$(dig +short $INGRESS_IPNAME) 

#     while [ -z "$INGRESS_IP" ]; do
#         sleep 10
#         INGRESS_IPNAME=$(kubectl --namespace projectcontour get service contour-envoy --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")
#         INGRESS_IP=$(dig +short $INGRESS_IPNAME) 
#     done

} else {

    mut ingress_ip = ""; while $ingress_ip == "" {
        print "Waiting for Ingress Service IP..."
        $ingress_ip = (
            kubectl --namespace projectcontour
                get service contour-envoy --output yaml
                | from yaml
                | get status.loadBalancer.ingress.0.ip
        )
    }
}

# INGRESS_IP=$(echo $INGRESS_IP | awk '{print $1;}')

# INGRESS_IP_LINES=$(echo $INGRESS_IP | wc -l | tr -d ' ')

# if [ $INGRESS_IP_LINES -gt 1 ]; then
#     INGRESS_IP=$(echo $INGRESS_IP | head -n 1)
# fi

$"export INGRESS_HOST=($ingress_ip)\n" | save --append .env
open settings.yaml
    | upsert ingress.host $"($ingress_ip).nip.io"
    | save settings.yaml --force

"export INGRESS_CLASSNAME=contour\n" | save --append .env
open settings.yaml
    | upsert ingress.classname "contour"
    | save settings.yaml --force

header "Setup the App"

let image = "index.docker.io/vfarcic/cncf-demo"

open settings.yaml
    | upsert image $image
    | save settings.yaml --force

open settings.yaml
    | upsert tag "v0.0.1"
    | save settings.yaml --force

let template = [kustomize helm ytt cdk8s]
    | input list $"(ansi green_bold)How would you like to define Kubernetes resources?(ansi reset)(ansi yellow_bold)"

if $template == "kustomize" {

    open $"($gitops_app)/cncf-demo-kustomize.yaml"
        | upsert spec.source.repoURL $repo_url
        | save $"($gitops_app)/cncf-demo-kustomize.yaml" --force

    open kustomize/base/deployment.yaml
        | upsert spec.template.spec.containers.0.image $image
        | save kustomize/base/deployment.yaml --force

    cd kustomize/overlays/prod

    kustomize edit set image $"($image)=($image):v0.0.1"

    cd ../../..

    open kustomize/overlays/prod/kustomization.yaml
        | upsert patchesStrategicMerge []
        | save kustomize/overlays/prod/kustomization.yaml --force

} else if $template == "helm" {

    open $"($gitops_app)/cncf-demo-helm.yaml"
        | upsert spec.source.repoURL $repo_url
        | upsert spec.source.helm.valuesObject.image.tag v0.0.1
        | upsert spec.source.helm.valuesObject.tls.enabled false
        | save $"($gitops_app)/cncf-demo-helm.yaml" --force

    open helm/app/values.yaml
        | upsert image.repository $image
        | save helm/app/values.yaml --force

} else if $template == "cdk8s" {

    open $"($gitops_app)/cncf-demo-cdk8s.yaml"
        | upsert spec.source.repoURL $repo_url
        | save $"($gitops_app)/cncf-demo-cdk8s.yaml" --force

    open cdk8s/app-prod.yaml
        | upsert image.repository $image
        | upsert image.tag v0.0.1
        | save cdk8s/app-prod.yaml --force

} else {

    open $"($gitops_app)/cncf-demo-ytt.yaml"
        | upsert spec.source.repoURL $repo_url
        | save $"($gitops_app)/cncf-demo-ytt.yaml" --force

    open ytt/values-prod.yaml
        | upsert image.repository $image
        | upsert image.tag v0.0.1
        | save ytt/values-prod.yaml --force

}

header "Setup Crossplane"

(
    helm repo add crossplane-stable
        https://charts.crossplane.io/stable
)

helm repo update

(
    helm upgrade --install crossplane crossplane-stable/crossplane
        --namespace crossplane-system --create-namespace --wait
)

(
    kubectl apply --filename
        crossplane-config/provider-kubernetes-incluster.yaml
)

kubectl apply --filename crossplane-config/config-sql.yaml

sleep 60sec

(
    kubectl wait provider.pkg.crossplane.io
        --for=condition=healthy --all --timeout=600s
)

if $hyperscaler == "google" {

    (
        kubectl --namespace crossplane-system
            create secret generic gcp-creds
            --from-file creds=./gcp-creds.json
    )

    $"apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  projectID: ($project_id)
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gcp-creds
      key: creds" | kubectl apply --filename -

    open settings.yaml
        | upsert crossplane.destination "google"
        | save settings.yaml --force

# } else if $hyperscaler == "aws" {

#     kubectl --namespace crossplane-system create secret generic aws-creds --from-file creds=./aws-creds.conf

#     kubectl apply --filename crossplane-config/provider-config-aws-official.yaml

#     yq --inplace ".crossplane.destination = \"aws\"" settings.yaml

# elif [[ "$HYPERSCALER" == "azure" ]]; then

#     export SUBSCRIPTION_ID=$(az account show --query id -o tsv)

#     az ad sp create-for-rbac --sdk-auth --role Owner --scopes /subscriptions/$SUBSCRIPTION_ID | tee azure-creds.json

#     kubectl --namespace crossplane-system create secret generic azure-creds --from-file creds=./azure-creds.json

#     kubectl apply --filename crossplane-config/provider-config-azure-official.yaml

#     yq --inplace ".crossplane.destination = \"azure\"" settings.yaml

}

print $"(ansi purple_bold)
##################
# Setup Database #
##################
(ansi reset)"

if $template == "kustomize" {

    let resources = open kustomize/overlays/prod/kustomization.yaml
        | get resources
        | append $"postgresql-crossplane-($hyperscaler).yaml"
        | append $"postgresql-crossplane-secret-($hyperscaler).yaml"
        | append $"postgresql-crossplane-schema-($hyperscaler).yaml"
    
    let patchesStrategicMerge = open kustomize/overlays/prod/kustomization.yaml
        | get patchesStrategicMerge
        | append $"deployment-crossplane-postgresql-($hyperscaler).yaml"

    open kustomize/overlays/prod/kustomization.yaml
        | upsert resources $resources
        | upsert patchesStrategicMerge $patchesStrategicMerge
        | save kustomize/overlays/prod/kustomization.yaml --force

} else if $template == "helm" {

    open argocd/cncf-demo-helm.yaml
        | upsert ([spec source helm valuesObject db enabled crossplane $hyperscaler ] | into cell-path) true
        | upsert spec.source.helm.valuesObject.db.insecure true
        | save argocd/cncf-demo-helm.yaml --force

} else if $template == "cdk8s" {

    open cdk8s/app-prod.yaml
        | upsert ([db enabled crossplane $hyperscaler ] | into cell-path) true
        | upsert db.id "cncf-demo-db"
        | upsert db.insecure true
        | upsert db.size "small"
        | upsert schemahero.enabled true
        | save cdk8s/app-prod.yaml --force

    cd cdk8s

    ENVIRONMENT=prod cdk8s synth --output ../yaml/prod --validate

    cd ../

} else {

    open ytt/values-prod.yaml
        | upsert ([db enabled crossplane $hyperscaler ] | into cell-path) true
        | upsert db.id "cncf-demo-db"
        | upsert db.insecure true
        | upsert db.size "small"
        | upsert schemahero.enabled true
        | save ytt/values-prod.yaml --force

    (
        ytt --file ytt/schema.yaml --file ytt/resources
            --data-values-file ytt/values-prod.yaml
            | save yaml/prod/app.yaml --force
    )

}

print $"(ansi purple_bold)
#########################
# Setup Database Schema #
#########################
(ansi reset)"

cp argocd/schema-hero.yaml infra/.

git add .

git commit -m "SchemaHero"

git push
