# Setup Prerequisites

```bash
gh repo fork vfarcic/cncf-demo --clone --remote

cd cncf-demo

gh repo set-default

eval "$(teller sh)"

eksctl create cluster --config-file eksctl/config-cilium.yaml

kubectl --namespace kube-system patch daemonset aws-node \
    --type strategic \
    --patch '{"spec":{"template":{"spec":{"nodeSelector":{"io.cilium/aws-node-enabled":"true"}}}}}'

helm install cilium cilium/cilium --version "1.14.2" \
    --namespace kube-system --set eni.enabled=true \
    --set ipam.mode=eni --set routingMode=native \
    --set egressMasqueradeInterfaces=eth0 --wait

eksctl create addon --name aws-ebs-csi-driver \
    --cluster dot-production \
    --service-account-role-arn arn:aws:iam::$AWS_ACCOUNT_ID:role/AmazonEKS_EBS_CSI_DriverRole \
    --region us-east-1 --force

kubectl create namespace production

yq --inplace ".image = \"index.docker.io/vfarcic/cncf-demo\"" \
    settings.yaml

yq --inplace ".tag = \"v0.0.1\"" settings.yaml

alias curl="curl --insecure"

chmod +x capi/*.sh

chmod +x crossplane/*.sh

chmod +x manuscript/gitops/*.sh

chmod +x manuscript/ingress/*.sh

chmod +x manuscript/app/*.sh

chmod +x manuscript/cluster/*.sh
```

## Crossplane

```bash

./manuscript/cluster/crossplane.sh

./manuscript/cluster/crossplane-aws.sh

source .env

kubectl --namespace production apply \
    --filename crossplane/aws-eks.yaml
```

## CAPI

```bash
export AWS_REGION=us-east-1

export CLUSTER_TOPOLOGY=true

export EXP_CLUSTER_RESOURCE_SET=true

export EXP_MACHINE_POOL=true

export CAPA_EKS_IAM=true

export CAPA_EKS_ADD_ROLES=true

export EXP_EKS_FARGATE=true

export AWS_SSH_KEY_NAME=default

export AWS_NODE_MACHINE_TYPE=t3.medium

clusterctl init

clusterawsadm bootstrap iam create-cloudformation-stack \
    --config capi-config/capa-iam-config.yaml

aws ec2 create-key-pair --key-name default --output json \
    | jq .KeyMaterial -r

export AWS_B64ENCODED_CREDENTIALS=$(\
    clusterawsadm bootstrap credentials encode-as-profile)

clusterctl init --infrastructure aws

yq --inplace ".capi.destination = \"aws\"" settings.yaml

clusterctl generate cluster production \
    --flavor eks-managedmachinepool-vpccni \
    --kubernetes-version v1.28.1 --worker-machine-count 3 \
    --target-namespace production \
    | tee capi/aws-eks.yaml

kubectl apply --filename capi/aws-eks.yaml
```

## The Rest

```bash
kubectl get managed | grep False

kubectl --namespace production get \
    clusters,awsmanagedclusters,awsmanagedcontrolplanes,machinepools,awsmanagedmachinepools

export GITHUB_USER=vfarcic

export GITHUB_ORG=devopsparadox

export IMAGE=index.docker.io/vfarcic/cncf-demo

export TAG=v0.0.1
```

## Start The Chapter

* [Cluster API](../cluster/kubecon-capi-aws)
* [Crossplane](../cluster/kubecon-crossplane-aws.md)

## The Flow

```mermaid
flowchart TD

    subgraph Production

        %% -----------
        %% -- Setup --
        %% -----------
        setup-prod((Setup))
        click setup-prod "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/setup/prod.md"

        %% -- Setup Connections --
        setup-prod-->cluster

        %% -------------
        %% -- Cluster --
        %% -------------
        cluster{{Create a Cluster}}
        click cluster "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/README.md"
        style cluster fill:blue
        cluster-crossplane(Crossplane)
        click cluster-crossplane "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/crossplane.md"
        cluster-crossplane-aws(AWS)
        click cluster-crossplane-aws "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/cluster-crossplane-aws.md"
        cluster-cluster-api(Cluster API)
        click cluster-cluster-api "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/cluster-api.md"
        capi-aws(AWS)
        click capi-aws "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/capi-aws.md"
        cluster --> cluster-crossplane --> cluster-crossplane-aws --> gitops
        cluster --> cluster-cluster-api --> capi-aws --> gitops

        %% ------------
        %% -- GitOps --
        %% ------------
        gitops{{GitOps}}
        click gitops "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/gitops/README.md"
        style gitops fill:blue
        gitops-flux(Flux)
        click gitops-flux "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/gitops/flux.md"
        gitops-argocd(Argo CD)
        click gitops-argocd "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/gitops/argocd.md"
        gitops-kapp(Carvel kapp-controller)
        click gitops-kapp "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/gitops/kapp.md"
        gitops --> gitops-flux & gitops-argocd & gitops-kapp --> ingress

        %% -------------
        %% -- Ingress --
        %% -------------
        ingress{{Ingress}}
        click ingress "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/ingress/README.md"
        style ingress fill:blue
        ingress-contour(Contour With Envoy)
        click ingress-contour "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/ingress/contour.md"
        ingress-nginx(NGINX)
        click ingress-nginx "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/ingress/nginx.md"
        emissary-ingress(Emissary-ingress With Envoy)
        click ingress-nginx "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/ingress/emissary-ingress.md"
        ingress-argocd(GitOps With Argo CD)
        click ingress-argocd "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/ingress/gitops-argocd.md"
        ingress-flux(GitOps Flux)
        click ingress-flux "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/ingress/gitops-flux.md"
        ingress-kapp(GitOps Carvel kapp-controller)
        click ingress-kapp "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/ingress/gitops-kapp.md"
        ingress-->ingress-contour & ingress-nginx & emissary-ingress --> ingress-argocd & ingress-flux & ingress-kapp --> app

        %% ----------------------------------
        %% -- Deploy The App To Production --
        %% ----------------------------------
        app{{Deploy The App To Production}}
        click app "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/app/README.md"
        style app fill:blue
        app-helm(App As Helm)
        click app-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/app/helm.md"
        app-kustomize(App As Kustomize)
        click app-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/app/kustomize.md"
        app-cdk8s(App As cdk8s)
        click app-cdk8s "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/app/cdk8s.md"
        app-carvel(App As Carvel ytt)
        click app-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/app/carvel.md"
        app --> app-helm & app-kustomize & app-cdk8s & app-carvel --> prod-done

        prod-done((Chapter End))

    end
```

## Destroy

```bash
chmod +x manuscript/destroy/production.sh

./manuscript/destroy/production.sh

eksctl delete addon --name aws-ebs-csi-driver \
    --cluster dot-production --region us-east-1

eksctl delete nodegroup --name primary --cluster dot-production \
    --drain=false --region us-east-1 --wait

eksctl delete cluster --config-file eksctl/config-cilium.yaml \
    --wait
```