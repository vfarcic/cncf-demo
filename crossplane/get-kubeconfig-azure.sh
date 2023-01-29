kubectl --namespace production get secret production-cluster \
    --output jsonpath="{.data.kubeconfig}" \
    | base64 -d | tee kubeconfig-prod.yaml

chmod 600 kubeconfig-prod.yaml
