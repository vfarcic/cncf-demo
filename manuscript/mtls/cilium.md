# Mutual TLS (mTLS) And Network Policies With Cilium And SPIFFE

TODO: Intro

## Setup

* Cilium is already installed in the cluster by default if you followed the provided setup instructions.

```bash
chmod +x manuscript/mtls/cilium.sh

./manuscript/mtls/cilium.sh
```

## Authorization (mTLS)

```bash
cat cilium/mtls.yaml

kubectl --namespace production apply --filename cilium/mtls.yaml

kubectl --namespace production get ciliumendpoints

IDENTITY_ID=$(kubectl --namespace production \
    get ciliumendpoints --selector app=sleep \
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

## Policies

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

```sh
kubectl --namespace production delete \
    --filename cilium/network-policy.yaml

kubectl --namespace production delete --filename cilium/mtls.yaml

kubectl --namespace default delete --filename cilium/mtls.yaml
```

## Continue The Adventure

* [Kubernetes Scanning](../scanning/README.md)
