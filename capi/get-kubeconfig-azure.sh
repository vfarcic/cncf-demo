kubectl --namespace production get secret production-kubeconfig \
   -o jsonpath={.data.value} | base64 --decode \
   > kubeconfig-prod.yaml

chmod 600 kubeconfig-prod.yaml