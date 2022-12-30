# Create And Manage Production Google Cloud Cluster With Crossplane

TODO: Intro

## Setup

```bash
echo "https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$XP_PROJECT_ID"

# Open the URL and *ENABLE* the API

export GOOGLE_APPLICATION_CREDENTIALS=$PWD/gcp-creds.json

export GCP_B64ENCODED_CREDENTIALS=$(\
    cat $GOOGLE_APPLICATION_CREDENTIALS | base64 | tr -d '\n')

clusterctl init --infrastructure gcp

export GCP_REGION=us-east1

export GCP_PROJECT=$XP_PROJECT_ID

export GCP_PROJECT_ID=$XP_PROJECT_ID

export GCP_CONTROL_PLANE_MACHINE_TYPE=n1-standard-2

export GCP_NODE_MACHINE_TYPE=n1-standard-2

export GCP_NETWORK_NAME=default

git clone https://github.com/kubernetes-sigs/image-builder.git

kubectl create namespace production

# TODO: Create Cloud NAT in the project
```

## Do

```bash
export XP_DESTINATION=google

cd image-builder/images/capi

make deps-gce

make build-gce-ubuntu-2004

cd ../../..

gcloud compute images list --project $GCP_PROJECT \
    --no-standard-images

# Replace `[...]` with the Kubernetes version from the image
#   name suffix (e.g., `v1.23.10`)
export CAPI_K8S_VERSION=[...]

# Replace `[...]` with the image name
#   (e.g,. `cluster-api-ubuntu-2004-v1-23-10-1672361474`)
export IMAGE_NAME=[...]

# This is the image you built. See https://github.com/kubernetes-sigs/image-builder
export IMAGE_ID=projects/$GCP_PROJECT/global/images/$IMAGE_NAME

clusterctl generate cluster production \
    --kubernetes-version $CAPI_K8S_VERSION \
    --control-plane-machine-count 3 --worker-machine-count 3 \
    --target-namespace production \
    | tee capi/production.yaml

kubectl apply --filename capi/production.yaml

kubectl --namespace production get clusters

clusterctl --namespace production describe cluster production

kubectl --namespace production get kubeadmcontrolplane

clusterctl --namespace production get kubeconfig production \
    | tee kubeconfig-prod.yaml

kubectl --kubeconfig kubeconfig-prod.yaml \
  apply --filename https://raw.githubusercontent.com/kubernetes-sigs/cluster-api-provider-azure/main/templates/addons/calico.yaml

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

# TODO: Rewrite

kubectl get managed

kubectl --namespace production get clusterclaims

cat crossplane/get-kubeconfig-$XP_DESTINATION.sh

./crossplane/get-kubeconfig-$XP_DESTINATION.sh

kubectl get nodes
```

## Continue The Adventure

[GitOps](../gitops/story.md)
