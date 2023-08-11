# Create and Manage Production Google Cloud GKE Cluster with Crossplane

In this section, we will create and manage a production-grade Google Cloud GKE cluster using Crossplane.

Among other things, this involves:
* installing the Crossplane GCP Provider which creates a new Kubernetes API for every external Google Cloud API
* creating the GCP Provider Config which provides Crossplane with credentials to be able to access and change Google Cloud resources

Once this is done, we are able to provision Kubernetes clusters in Google Cloud using Crossplane Custom Resources. 

## Setup

* You can skip the steps in this section (Setup) if you already used Crossplane with Google in one of the previous chapters.

```bash
export XP_PROJECT_ID=$(yq ".production.google.projectId" \
  settings.yaml)

echo "https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$XP_PROJECT_ID"

# Open the URL and *ENABLE* the API

kubectl --namespace crossplane-system \
    create secret generic gcp-creds \
    --from-file creds=./gcp-creds.json

kubectl get pkgrev

# Wait until all the packages are healthy

echo "apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  projectID: $XP_PROJECT_ID
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gcp-creds
      key: creds" \
    | kubectl apply --filename -

yq --inplace ".crossplane.destination = \"google\"" settings.yaml
```

## Do

```bash
cat crossplane/google-gke.yaml

kubectl --namespace production apply \
    --filename crossplane/google-gke.yaml

kubectl get managed

kubectl --namespace production get claim

# Wait until the claim is ready

cat crossplane/get-kubeconfig-google.sh

chmod +x crossplane/get-kubeconfig-google.sh

./crossplane/get-kubeconfig-google.sh

export KUBECONFIG=$PWD/kubeconfig-prod.yaml

yq --inplace \
  ".production.kubeConfig = \"$PWD/kubeconfig-prod.yaml\"" \
    settings.yaml

kubectl get nodes
```

## Continue the adventure

* [GitOps](../gitops/README.md)
