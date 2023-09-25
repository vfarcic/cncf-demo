# Mutual TLS (mTLS) And Network Policies With Istio

TODO: Intro

## Setup

```bash
# We'll install LinkerD manually instead of using Argo CD, Flux,
#   or Carvel kapp-controller since that would require us to
#   generate certificates manually (the CLI does that for us).
# In the "real world" situation, you should do it through GitOps
#   by using LinkerD's Helm chart and your own certificates.

# TODO: Continue

curl --proto '=https' --tlsv1.2 \
    -sSfL https://run.linkerd.io/install | sh

linkerd check --pre

linkerd install --crds | kubectl apply --filename -

linkerd install | kubectl apply --filename -

linkerd viz install | kubectl apply --filename -

linkerd check
```

# Do

```bash
cat linkerd/namespace-production.yaml

cp linkerd/namespace-production.yaml apps/.

git add . 

git commit -m "Istio"

git push

kubectl get namespace production --output yaml

# Wait until the `istio-injection` label was added.

kubectl --namespace production delete pods \
    --selector app.kubernetes.io/name=cncf-demo

kubectl --namespace production get pods

# Istio side-car is now added to the Pods
```

## Authorization (mTLS)

```bash
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

## Authentication

TODO: Continue

```bash
cat istio/peer-authentication.yaml

kubectl --namespace production apply \
    --filename istio/peer-authentication.yaml

kubectl --namespace production --tty --stdin exec sleep -- sh

curl http://cncf-demo.production:8080 -w "%{http_code}\n"

# Both apps are "meshed", so the communication is allowed.

exit

kubectl --namespace default apply --filename istio/mtls.yaml

kubectl --namespace default --tty --stdin exec sleep -- sh

apk add -U curl

curl http://cncf-demo.production:8080 -w "%{http_code}\n"

# The communication is not allowed since the Pod in the
#   `default` Namespace is NOT "meshed" and therefore not
#   authenticated.

exit
```

## Policies

```bash
cat istio/authorization-policy-deny.yaml

kubectl --namespace production apply \
    --filename istio/authorization-policy-deny.yaml

kubectl --namespace production --tty --stdin exec sleep -- sh

curl http://cncf-demo.production:8080

# The access was denied

exit

cat istio/authorization-policy-allow.yaml

kubectl --namespace production apply \
    --filename istio/authorization-policy-allow.yaml

kubectl --namespace production --tty --stdin exec sleep -- sh

curl http://cncf-demo.production:8080

# The access was allowed
```

## Destroy

```bash
kubectl --namespace production delete --filename istio/mtls.yaml

kubectl --namespace production delete \
    --filename istio/peer-authentication.yaml

kubectl --namespace default delete --filename istio/mtls.yaml

kubectl --namespace production delete \
    --filename istio/authorization-policy-allow.yaml
```

## Continue The Adventure

* [Mutual TLS And Network Policies](../scanning/README.md)
