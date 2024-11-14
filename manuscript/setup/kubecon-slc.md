# Setup

```bash
gh repo fork vfarcic/cncf-demo --clone --remote --org devopsparadox

cd cncf-demo

gh repo set-default

devbox shell

eval "$(teller sh)"

./manuscript/setup/kubecon-slc-observability.sh

source .env

zellij

kubectl --namespace argocd port-forward  svc/argocd-server 8080:80

open "http://localhost:8080"

./manuscript/metrics/kubecon-slc-prometheus.sh

px auth login

px deploy --cluster_name dot -y

./manuscript/tracing/kubecon-slc-jaeger.sh

./manuscript/mtls/kubecon-slc-istio.sh

source .env

kubectl get pods --all-namespaces

kubectl --namespace production delete pods \
    --selector app.kubernetes.io/name=cncf-demo

kubectl --namespace production get pods

./manuscript/progressive-delivery/kubecon-slc.sh

./manuscript/progressive-delivery/kubecon-slc-argo-rollouts.sh

./manuscript/progressive-delivery/kubecon-slc-flagger.sh istio

source .env
```

## Start The Chapter

* [Prometheus](../metrics/kubecon-slc-prometheus.md)
* [Pixie](../metrics/kubecon-slc-pixie.md)