export KUBECONFIG=$PWD/kubeconfig-dev.yaml

kubectl --namespace production get secret production-cluster \
    --output jsonpath="{.data.kubeconfig}" \
    | base64 -d | tee kubeconfig-prod.yaml
