aws eks update-kubeconfig --region us-east-1 \
    --name production --kubeconfig $PWD/kubeconfig-prod.yaml

chmod 600 kubeconfig-prod.yaml
