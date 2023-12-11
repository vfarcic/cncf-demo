# Setup Prerequisites

Prepare for your adventure! Get the right equipment! Think of the instructions in this section as adventure prerequisites. This is not the adventure itself (that comes soon) but ensurance that you are ready for it.

**GET READY FOR ADVENTURE!**
______________

```bash
# Watch https://youtu.be/BII6ZY2Rnlc if you are not familiar
#   with GitHub CLI.
gh repo fork vfarcic/cncf-demo --clone --remote

cd cncf-demo

# Select the fork as the default repository

gh repo set-default
```

In later steps, when you create your cluster, a `kubeconfig` file will get created which has your cluster connection credentials (among other things).

 Tell your cluster creation tool which file to use for Kubernetes to store its configuration -- `kubeconfig-dev.yaml`. That file has already been added to `.gitignore`.

```bash
export KUBECONFIG=$PWD/kubeconfig-dev.yaml
```

Next we'll create a hidden `.env` file where you can store important stuff that you might need later. First, store a command to create a `KUBECONFIG_DEV` variable with the path to your `kubeconfig-dev.yaml`. Depending on your journey, you might need this later.

```bash
echo "export KUBECONFIG_DEV=$PWD/kubeconfig-dev.yaml" >> .env
```

## Create a management Kubernetes cluster

### AWS EKS

Follow this section ONLY if you're planning to use AWS EKS

```bash
# Replace `[...]` with your access key ID`
export AWS_ACCESS_KEY_ID=[...]

# Replace `[...]` with your secret access key
export AWS_SECRET_ACCESS_KEY=[...]

# Replace `[...]` with your account ID
export AWS_ACCOUNT_ID=[...]

# Watch https://youtu.be/pNECqaxyewQ if you are not familiar
#   with `eksctl`
eksctl create cluster --config-file eksctl/config-dev.yaml

eksctl create addon --name aws-ebs-csi-driver --cluster dot \
    --service-account-role-arn arn:aws:iam::$AWS_ACCOUNT_ID:role/AmazonEKS_EBS_CSI_DriverRole \
    --force
```

### Azure AKS

Follow this section ONLY if you're planning to use Azure AKS

```bash
export RESOURCE_GROUP=dot-$(date +%Y%m%d%H%M%S)

yq --inplace ".azure.resourceGroup = \"$RESOURCE_GROUP\"" \
    settings.yaml

az group create --location eastus --name $RESOURCE_GROUP

az aks get-versions --location eastus --output table

# Replace `[...]` with a valid Kubernetes version from the
#   previous output.
export K8S_VERSION=[...]

az aks create --name dot --resource-group $RESOURCE_GROUP \
    --node-count 3 --node-vm-size Standard_D2_v2 \
    --kubernetes-version $K8S_VERSION

az aks get-credentials --name dot \
    --resource-group $RESOURCE_GROUP --file $KUBECONFIG
```

### Google Cloud GKE

Follow this section ONLY if you're planning to use Google Cloud GKE

```bash
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# create a project

export PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

yq --inplace ".google.projectId = \"$PROJECT_ID\"" settings.yaml

gcloud projects create $PROJECT_ID

echo "https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$PROJECT_ID"

# Open the URL from the output and enable the Kubernetes API

# create a cluster

gcloud container clusters create dot --project $PROJECT_ID \
    --region us-east1 --machine-type e2-standard-4 \
    --num-nodes 1 --enable-network-policy \
    --no-enable-autoupgrade

# generate kubeconfig file

gcloud container clusters get-credentials dot \
    --project $PROJECT_ID --region us-east1
```

### Cluster With Any Other Provider

Follow this section ONLY if you're NOT planning to use EKS, AKS, or GKE

* Create a Kubernetes cluster any way you like, as long as it is not a local cluster (e.g., Docker Desktop, Minikube, etc.)

## The Rest Of The Setup

First, create a `dev` namespace!
```bash
kubectl create namespace dev
```
If needed, [install the `yq` CLI](https://github.com/mikefarah/yq). `yq` is a lightweight and portable command-line YAML processor.

If needed, [install `jq` CLI](https://stedolan.github.io/jq/download). `jq` is a lightweight and portable command-line JSON processor.

If needed, [install Helm](https://helm.sh/docs/intro/install/). Helm is a package manager for Kubernetes applications.

Install Traefik. Traefik is a reverse proxy server and load balancer that handles traffic that enters from outside of your Kubernetes cluster.

```bash
helm upgrade --install traefik traefik \
    --repo https://helm.traefik.io/traefik \
    --namespace traefik --create-namespace --wait
```
Depending on what cloud provider you chose for your adventure, the commands for finding your cluster IP are different. Only run the ones that apply to you. 

```bash
# If NOT EKS
export INGRESS_HOST=$(kubectl --namespace traefik \
    get service traefik \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

# Only if you ARE using EKS
export INGRESS_HOSTNAME=$(kubectl --namespace traefik \
    get service traefik \
    --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

# Only if you ARE using EKS
export INGRESS_HOST=$(dig +short $INGRESS_HOSTNAME) 

# This is the IP address by which you can access applications
#   running in your cluster!
echo $INGRESS_HOST

# Repeat the `export` commands if the output is empty.

# If the output contains more than one IP, wait for a while 
#   longer, and repeat the `export` commands.

# If the output continues having more than one IP, choose one of
#   them and execute `export INGRESS_HOST=[...]` with `[...]`
#   being the selected IP.
```

Use the output--your cluster's IP address--to configure DNS domain. Do this by going to your registrar and creating a DNS record of type 'A' with the value set to the IP address of your output.

If you do choose to use `nip.io` instead of a "real" domain, beware that:
   - when opening an application in a browser, you will have to
     allow insecure connections.
   - when executing `curl` commands, you will have to add the
     `--insecure` flag. There is a command below that will
      create an `alias` for `curl` that will add the
     `--insecure` argument.
   - you will NOT be able to choose Harbor as container image
     registry.
   - you will have to skip the **Use HTTPS** section coming
     later on in the story.

```bash
# Replace `[...]` with the domain (e.g., sillydemo.com).

# If you do not have a domain, replace `[...]` with `$INGRESS_HOST.nip.io`.

export DOMAIN=[...]
```

Execute this step ONLY if you chose to use `nip.io` instead of
  a "real" domain

```bash
alias curl="curl --insecure"
```
Configure DNS for the following subdomains (skip this step if you chose to use `nip.io` instead of a "real" domain):
   - harbor
   - notary
   - cncf-demo-dev

**Do not use a wildcard for those subdomains** since, later on, we'll add more pointing to a different cluster.
Configure these subdomains by going to your registrar and
creating three more DNS records of type 'A', each with the
name set to the subdomain (one record for 'harbor', one for
'notary', one for 'cncf-demo-dev'), and the value of each
record set to that same IP address of your output.
_________________________________

Deploy and configure cert-manager to automate the process of issuing and renewing TLS certificates.

```bash
# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain.
helm repo add jetstack https://charts.jetstack.io

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain.
helm repo update

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain.
helm upgrade --install cert-manager jetstack/cert-manager \
    --namespace cert-manager --create-namespace \
    --set installCRDs=true --wait
```
Create a cert-manager ClusterIssuer resource that can issue TLS certificates.
```bash
# Replace `[...]` with your email.
# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain.
export EMAIL=[...]

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain.
yq --inplace ".spec.acme.email = \"$EMAIL\"" \
    cert-manager/issuer.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain.
kubectl apply --filename cert-manager/issuer.yaml
```

## Start The Adventure
#### EEK! So exciting!!!

* [Build Container Image](../build-container-image/README.md)