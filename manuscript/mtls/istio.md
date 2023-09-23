# Mutual TLS (mTLS) And Network Policies With Istio

TODO: Intro

## Setup

```bash
# TODO: kapp-controller

export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cat $GITOPS_APP/istio.yaml

cp $GITOPS_APP/istio.yaml infra/.

git add . 

git commit -m "Istio"

git push

kubectl --namespace istio-system get pods

# Wait until the Pods are created and ready
```

# Do

```bash
cat istio/namespace-production.yaml

cp istio/namespace-production.yaml apps/.

git add . 

git commit -m "Istio"

git push

kubectl get namespace production --output yaml

# Wait until the `istio-injection` label was added.

kubectl --namespace production delete pods \
    --selector app.kubernetes.io/name=cncf-demo

kubectl --namespace production get pods

# Istio side-car is now added to the Pods

# TODO: Rewrite

kubectl exec "$(kubectl get pod -l app=sleep -n bar \
    -o jsonpath={.items..metadata.name})" -c sleep -n bar \
    -- curl http://httpbin.foo:8000/ip -s -o /dev/null \
    -w "%{http_code}\n"

kubectl exec "$(kubectl get pod -l app=sleep -n foo \
    -o jsonpath={.items..metadata.name})" -c sleep -n foo \
    -- curl -s http://httpbin.foo:8000/headers -s \
    | grep X-Forwarded-Client-Cert \
    | sed 's/Hash=[a-z0-9]*;/Hash=<redacted>;/'

kubectl exec "$(kubectl get pod -l app=sleep -n foo \
    -o jsonpath={.items..metadata.name})" -c sleep -n foo \
    -- curl http://httpbin.legacy:8000/headers -s \
    | grep X-Forwarded-Client-Cert

kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: "default"
  namespace: "foo"
spec:
  mtls:
    mode: STRICT
EOF

for from in "foo" "bar" "legacy"; do
    for to in "foo" "bar" "legacy"; do
        kubectl exec "$(kubectl get pod -l app=sleep -n ${from} \
        -o jsonpath={.items..metadata.name})" -c sleep \
        -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s \
        -o /dev/null \
        -w "sleep.${from} to httpbin.${to}: %{http_code}\n"
    done
done

############################
# Authorization with Istio #
############################

kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: allow-nothing
  namespace: foo
spec:
  {}
EOF

kubectl exec "$(kubectl get pod -l app=sleep -n bar \
    -o jsonpath={.items..metadata.name})" -c sleep -n bar \
    -- curl http://httpbin.foo:8000/ip -s -o /dev/null \
    -w "%{http_code}\n"

kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: "productpage-viewer"
  namespace: foo
spec:
  selector:
    matchLabels:
      app: httpbin
  action: ALLOW
  rules:
  - to:
    - operation:
        methods: ["GET"]
EOF

kubectl exec "$(kubectl get pod -l app=sleep -n bar \
    -o jsonpath={.items..metadata.name})" -c sleep -n bar \
    -- curl http://httpbin.foo:8000/ip -s -o /dev/null \
    -w "%{http_code}\n"

kubectl exec "$(kubectl get pod -l app=sleep -n bar \
    -o jsonpath={.items..metadata.name})" -c sleep -n bar \
    -- curl -XPOST http://httpbin.foo:8000/ip -s -o /dev/null \
    -w "%{http_code}\n"

#######################
# TODO: Pros And Cons #
#######################

# Cons:
# - TODO:

# Pros:
# - TODO:

###########
# Destroy #
###########

# TODO:

```

## Continue The Adventure

* [Mutual TLS And Network Policies](../mtls/README.md)
