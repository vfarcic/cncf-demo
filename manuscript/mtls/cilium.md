# Mutual TLS (mTLS) And Network Policies With Cilium And SPIFFE

TODO: Intro

## Setup

* Cilium is already installed in the cluster by default if you followed the provided setup instructions.

```bash
kubectl --namespace kube-system get pods \
    --selector app.kubernetes.io/part-of=cilium

# Confirm that Cilium is are running

helm upgrade cilium cilium/cilium --namespace kube-system \
    --set authentication.mutual.spire.enabled=true \
    --set authentication.mutual.spire.install.enabled=true \
    --reuse-values --wait

kubectl --namespace kube-system \
    rollout restart deployment/cilium-operator

çkubectl --namespace kube-system rollout restart ds/cilium
```

## Authorization (mTLS)

```bash
cat cilium/mtls.yaml

kubectl --namespace production apply --filename istio/mtls.yaml

kubectl --namespace production get cep

IDENTITY_ID=$(kubectl --namespace production get cep \
    --selector app=sleep \
    --output jsonpath='{.items[0].status.identity.id}')

echo $IDENTITY_ID

kubectl --namespace cilium-spire exec spire-server-0 \
    --container spire-server \
    -- /opt/spire/bin/spire-server entry show \
    -spiffeID spiffe://spiffe.cilium/identity/$IDENTITY_ID

kubectl --namespace cilium-spire exec spire-server-0 \
    --container spire-server \
    -- /opt/spire/bin/spire-server entry show \
    -selector cilium:mutual-auth

kubectl get ciliumidentities
```

## Authentication

```bash
# TODO: Continue https://docs.cilium.io/en/latest/network/servicemesh/mutual-authentication/mutual-authentication-example/#enforce-mutual-authentication
cat cilium/peer-authentication.yaml

kubectl --namespace production apply \
    --filename istio/peer-authentication.yaml

kubectl --namespace production --tty --stdin exec sleep \
    --container sleep -- sh

curl http://cncf-demo.production:8080 -w "%{http_code}\n"

# Both apps are "meshed", so the communication is allowed.

exit

kubectl --namespace default apply --filename istio/mtls.yaml

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
cat istio/authorization-policy-deny.yaml

kubectl --namespace production apply \
    --filename istio/authorization-policy-deny.yaml

kubectl --namespace production --tty --stdin exec sleep \
    --container sleep -- sh

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
