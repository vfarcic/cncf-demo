# Mutual TLS (mTLS) And Network Policies With Linkerd

TODO: Intro

## Setup

```bash
# We'll install Linkerd manually instead of using Argo CD, Flux,
#   or Carvel kapp-controller since that would require us to
#   generate certificates manually (the CLI does that for us).
# In the "real world" situation, you should do it through GitOps
#   by using Linkerd's Helm chart and your own certificates.

linkerd check --pre

linkerd install --crds | kubectl apply --filename -

linkerd install | kubectl apply --filename -

linkerd viz install | kubectl apply --filename -

linkerd check
```

## Do

```bash
cat linkerd/namespace-production.yaml

cp linkerd/namespace-production.yaml apps/.

git add . 

git commit -m "Linkerd"

git push

kubectl get namespace production --output yaml

# Wait until the `linkerd.io/inject` label was added.

kubectl --namespace production delete pods \
    --selector app.kubernetes.io/name=cncf-demo

kubectl --namespace production get pods

# Linkerd side-car is now added to the Pods
```

## Authorization (mTLS)

```bash
cat linkerd/mtls.yaml

kubectl --namespace production apply --filename linkerd/mtls.yaml

kubectl --namespace production --tty --stdin exec sleep \
    --container sleep -- sh

apk add -U curl

curl -s http://httpbin:8080/headers

exit

linkerd viz --namespace production edges pod

# The `SECURED` column shows that the communication between the
#   Pods is encrypted (mTLS)
```

## Policies

Since Cilium CNI is already set up, we will use its policies.

```bash
kubectl --namespace production --tty --stdin exec sleep \
    --container sleep -- apk add -U curl

cat cilium/network-policy.yaml

kubectl --namespace production apply \
    --filename cilium/network-policy.yaml

kubectl --namespace production --tty --stdin exec sleep \
    --container sleep -- \
    curl http://cncf-demo.production:8080 -w "%{http_code}\n"

# The communication is allowed since the `sleep` endpoint
#    in the `production` Namespace is allowed to talk with the
#   `cncf-demo` in the `production` Namespace.

kubectl --namespace default apply --filename cilium/mtls.yaml

kubectl --namespace default --tty --stdin exec sleep \
    --container sleep -- apk add -U curl

kubectl --namespace default --tty --stdin exec sleep \
    --container sleep -- \
    curl http://cncf-demo.production:8080 -w "%{http_code}\n"

# The communication is NOT allowed since the `sleep` endpoint
#    in the `default` Namespace is NOT allowed to talk with the
#   `cncf-demo` in the `production` Namespace.

# Stop `curl` (if it did not already time out) by pressing
#   `ctrl+c`.
```

## Destroy

```bash
kubectl --namespace production delete \
    --filename linkerd/mtls.yaml

kubectl --namespace default delete --filename cilium/mtls.yaml
```

## Continue The Adventure

* [Kubernetes Scanning](../scanning/README.md)