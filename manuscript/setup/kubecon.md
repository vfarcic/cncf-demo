# Setup Prerequisites

```bash
gh repo fork vfarcic/cncf-demo --clone --remote

cd cncf-demo

gh repo set-default

export KUBECONFIG=$PWD/kubeconfig-dev.yaml

yq --inplace ".kubeConfig = \"$PWD/kubeconfig-dev.yaml\"" \
    settings.yaml
```

## Create a management Kubernetes cluster

### Google Cloud GKE

Follow this section ONLY if you're planning to use Google Cloud GKE

```bash
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

yq --inplace ".google.projectId = \"$PROJECT_ID\"" settings.yaml

gcloud projects create $PROJECT_ID

echo "https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$PROJECT_ID"

# Open the URL from the output and enable the Kubernetes API

gcloud container get-server-config --region us-east1

# Replace `[...]` with a valid master version from the previous
#   output.
export K8S_VERSION=[...]

gcloud container clusters create dot --project $PROJECT_ID \
    --region us-east1 --machine-type n1-standard-4 \
    --num-nodes 1 --cluster-version $K8S_VERSION \
    --node-version $K8S_VERSION

gcloud container clusters get-credentials dot \
    --project $PROJECT_ID --region us-east1
```

### The Rest Of The Setup

```bash
kubectl create namespace dev

helm upgrade --install traefik traefik \
    --repo https://helm.traefik.io/traefik \
    --namespace traefik --create-namespace --wait

export INGRESS_HOST=$(kubectl --namespace traefik \
    get service traefik \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

echo $INGRESS_HOST

export DOMAIN=sillydemo.com

# Configure DNS for the following subdomains (skip this step if
#   you chose to use `nip.io` instead of a "real" domain):
# - harbor
# - notary
# - cncf-demo-dev
# Do not use a wildcard for those subdomains since, later on,
#   we'll add more pointing to a different cluster.
# Configure these subdomains by going to your registrar and
#   creating three more DNS records of type 'A', each with the
#   name set to the subdomain (one record for 'harbor', one for
#   'notary', one for 'cncf-demo-dev'), and the value of each
#   record set to that same IP address of your output.

helm repo add jetstack https://charts.jetstack.io

helm repo update

helm upgrade --install cert-manager jetstack/cert-manager \
    --namespace cert-manager --create-namespace \
    --set installCRDs=true --wait

export EMAIL=viktor@farcic.com

yq --inplace ".spec.acme.email = \"$EMAIL\"" \
    cert-manager/issuer.yaml

kubectl apply --filename cert-manager/issuer.yaml
```

## Cache

```bash
# Start Rancher Desktop

alias docker=$(which nerdctl)

docker image build --tag cncf-demo:v0.0.1 .

# Quit Rancher Desktop

unalias docker

# Start Docker

kbld --file kbld/deployment.yaml

pack build cncf-demo:v0.0.1

./manuscript/registry/harbor.sh

./manuscript/db/crossplane-cloud.sh

export XP_PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

export XP_DESTINATION=google

./manuscript/db/crossplane-google.sh

kubectl get nodes

kubectl get managed
```

## Start The Adventure

* [Build Container Image](../build-container-image/README.md)

# TODO:

* [Cloud Native Buildpacks (CNB)](buildpacks.md)

* [CDK For Kubernetes (cdk8s)](cdk8s.md)

* [Kustomize](cert-manager-kustomize.md)
* [cdk8s](cert-manager-cdk8s.md)

* [Kustomize](crossplane-kustomize.md)
* [cdk8s](crossplane-cdk8s.md)

* [Kustomize](schemahero-kustomize.md)
* [cdk8s](schemahero-cdk8s.md)

* [DevSpace](devspace.md)
* [Nocalhost](nocalhost.md)
* [Devfile](devfile.md)