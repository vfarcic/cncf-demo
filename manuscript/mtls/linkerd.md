# Mutual TLS (mTLS) And Network Policies With LinkerD

TODO: Intro

## Setup

```bash
# We'll install LinkerD manually instead of using Argo CD, Flux,
#   or Carvel kapp-controller since that would require us to
#   generate certificates manually (the CLI does that for us).
# In the "real world" situation, you should do it through GitOps
#   by using LinkerD's Helm chart and your own certificates.

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

git commit -m "LinkerD"

git push

kubectl get namespace production --output yaml

# Wait until the `linkerd.io/inject` label was added.

kubectl --namespace production delete pods \
    --selector app.kubernetes.io/name=cncf-demo

kubectl --namespace production get pods

# LinkerD side-car is now added to the Pods
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

## Authentication

```bash
cat linkerd/peer-authentication.yaml

cp linkerd/peer-authentication.yaml \
    apps/namespace-production.yaml

git add . 

git commit -m "LinkerD"

git push

kubectl get namespace production --output yaml

# Wait until the `config.linkerd.io/default-inbound-policy`
#   annotation was added.

kubectl --namespace production delete pods \
    --selector app.kubernetes.io/name=cncf-demo

kubectl --namespace production --tty --stdin exec sleep \
    --container sleep -- sh

curl http://cncf-demo.production:8080 -w "%{http_code}\n"

# Both apps are "meshed", so the communication is allowed.

exit

kubectl --namespace default apply --filename linkerd/mtls.yaml

kubectl --namespace default --tty --stdin exec sleep \
    --container sleep -- sh

apk add -U curl

curl http://cncf-demo.production:8080 -w "%{http_code}\n"

# The communication is not allowed since the Pod in the
#   `default` Namespace is NOT "meshed" and therefore not
#   authenticated.

exit
```

## Policies

```bash
echo "
spec:
  template:
    metadata:
      annotations:
        config.linkerd.io/default-inbound-policy: deny
" | tee tmp/patch.yaml

kubectl --namespace production patch deployment cncf-demo \
    --patch-file tmp/patch.yaml

kubectl --namespace production --tty --stdin exec sleep \
    --container sleep -- sh

curl http://cncf-demo.production:8080

# The access was denied

exit

echo "
spec:
  template:
    metadata:
      annotations:
        config.linkerd.io/default-inbound-policy: all-authenticated
" | tee tmp/patch.yaml

kubectl --namespace production patch deployment cncf-demo \
    --patch-file tmp/patch.yaml

kubectl --namespace production --tty --stdin exec sleep -- sh

curl http://cncf-demo.production:8080

# The access was allowed

exit
```

## Destroy

```bash
kubectl --namespace production delete --filename istio/mtls.yaml

kubectl --namespace default delete --filename istio/mtls.yaml
```

## Continue The Adventure

* [Mutual TLS And Network Policies](../scanning/README.md)
