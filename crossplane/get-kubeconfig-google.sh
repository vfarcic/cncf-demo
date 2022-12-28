export KUBECONFIG=$PWD/kubeconfig-prod.yaml

gcloud container clusters get-credentials production --region us-east1 \
    --project $XP_PROJECT_ID
