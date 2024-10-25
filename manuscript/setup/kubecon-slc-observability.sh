#!/bin/sh
set -e

################
# Hyperscalers #
################

HYPERSCALER=aws
echo "export HYPERSCALER=$HYPERSCALER" >> .env
yq --inplace ".hyperscaler = \"$HYPERSCALER\"" settings.yaml

export KUBECONFIG=$PWD/kubeconfig.yaml
echo "export KUBECONFIG=$KUBECONFIG" >> .env

helm repo update

echo "[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
" >aws-creds.conf

eksctl create cluster --config-file eksctl/config.yaml \
    --kubeconfig kubeconfig.yaml

sleep 10

eksctl create addon --name aws-ebs-csi-driver --cluster dot-production \
    --service-account-role-arn arn:aws:iam::$AWS_ACCOUNT_ID:role/AmazonEKS_EBS_CSI_DriverRole \
    --region us-east-1 --force

################
# Setup GitOps #
################

kubectl create namespace production

REPO_URL=$(git config --get remote.origin.url)

yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/apps.yaml

helm upgrade --install argocd argo-cd \
    --repo https://argoproj.github.io/argo-helm \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

kubectl apply --filename argocd/project.yaml

kubectl apply --filename argocd/apps.yaml

GITOPS_APP=argocd

echo "export GITOPS_APP=$GITOPS_APP" >> .env

yq --inplace ".gitOps.app = \"$GITOPS_APP\"" settings.yaml

#################
# Setup Ingress #
#################

cp $GITOPS_APP/contour.yaml infra/.

git add . 

git commit -m "Contour"

git push

COUNTER=$(kubectl --namespace projectcontour get pods)

while [ -z "$COUNTER" ]; do
    sleep 10
    COUNTER=$(kubectl --namespace projectcontour get pods)
done

sleep 15

INGRESS_IPNAME=$(kubectl --namespace projectcontour get service contour-envoy --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

INGRESS_IP=$(dig +short $INGRESS_IPNAME) 

while [ -z "$INGRESS_IP" ]; do
    sleep 10
    INGRESS_IPNAME=$(kubectl --namespace projectcontour get service contour-envoy --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")
    INGRESS_IP=$(dig +short $INGRESS_IPNAME) 
done

INGRESS_IP=$(echo $INGRESS_IP | awk '{print $1;}')

INGRESS_IP_LINES=$(echo $INGRESS_IP | wc -l | tr -d ' ')

if [ $INGRESS_IP_LINES -gt 1 ]; then
    INGRESS_IP=$(echo $INGRESS_IP | head -n 1)
fi

INGRESS_HOST=$INGRESS_IP.nip.io
echo "export INGRESS_HOST=$INGRESS_HOST" >> .env
yq --inplace ".ingress.host = \"$INGRESS_HOST\"" settings.yaml

INGRESS_CLASSNAME=contour
echo "export INGRESS_CLASSNAME=contour" >> .env
yq --inplace ".ingress.classname = \"contour\"" settings.yaml

#################
# Setup The App #
#################

yq --inplace ".image = \"index.docker.io/vfarcic/cncf-demo\"" settings.yaml

yq --inplace ".tag = \"v0.0.1\"" settings.yaml

TEMPLATES=ytt

echo "export TEMPLATES=$TEMPLATES" >> .env
yq --inplace ".templates = \"$TEMPLATES\"" settings.yaml

yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    $GITOPS_APP/cncf-demo-ytt.yaml

yq --inplace \
    ".image.repository = \"index.docker.io/vfarcic/cncf-demo\"" \
    ytt/values-prod.yaml

yq --inplace ".image.tag = \"v0.0.1\"" ytt/values-prod.yaml

yq --inplace ".ingress.host = \"cncf-demo.$INGRESS_HOST\"" \
    ytt/values-prod.yaml

yq --inplace ".ingress.className = \"$INGRESS_CLASSNAME\"" \
    ytt/values-prod.yaml

####################
# Setup Crossplane #
####################

set +e
helm repo add crossplane-stable https://charts.crossplane.io/stable 
set -e

helm repo update

helm upgrade --install crossplane crossplane-stable/crossplane \
    --namespace crossplane-system --create-namespace --wait

kubectl apply \
    --filename crossplane-config/provider-kubernetes-incluster.yaml

kubectl apply \
    --filename crossplane-config/provider-helm-incluster.yaml

kubectl apply --filename crossplane-config/config-sql.yaml

sleep 60

kubectl wait --for=condition=healthy provider.pkg.crossplane.io --all --timeout=600s

kubectl --namespace crossplane-system create secret generic aws-creds --from-file creds=./aws-creds.conf

kubectl apply --filename crossplane-config/provider-config-aws-official.yaml

yq --inplace ".crossplane.destination = \"aws\"" settings.yaml

##################
# Setup Database #
##################

yq --inplace ".db.enabled.crossplane.$HYPERSCALER = true" \
    ytt/values-prod.yaml

yq --inplace ".db.id = \"cncf-demo-db\"" ytt/values-prod.yaml

yq --inplace ".db.insecure = true" ytt/values-prod.yaml

yq --inplace ".db.size = \"small\"" ytt/values-prod.yaml

yq --inplace ".schemahero.enabled = true" ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml | tee yaml/prod/app.yaml

#######################
# Setup Dabase Schema #
#######################

cp argocd/schema-hero.yaml infra/.

git add .

git commit -m "SchemaHero"

git push

#############
# Setup App #
#############

cp $GITOPS_APP/cncf-demo-$TEMPLATES.yaml apps/cncf-demo.yaml

git add .

git commit -m "CNCF Demo"

git push
