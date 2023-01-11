export KUBECONFIG=$PWD/kubeconfig-dev.yaml

aws eks update-kubeconfig --region us-east-1 \
    --name production --kubeconfig $PWD/kubeconfig-prod.yaml
