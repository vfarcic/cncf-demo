export KUBECONFIG=$PWD/kubeconfig-dev.yaml

gcloud container clusters get-credentials production --region us-east1 \
    --project $XP_PROJECT_ID

chmod 600 kubeconfig-prod.yaml
