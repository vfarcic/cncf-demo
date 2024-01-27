# Runtime Policies With Falco

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
# TODO: kapp-controller

chmod +x manuscript/runtime-policies/falco.sh

./manuscript/runtime-policies/falco.sh
```

## Do

```bash
kubectl --namespace production exec -it cncf-demo-controller-0 \
    -- sh -c "ls /"

kubectl --namespace falco logs \
    --selector app.kubernetes.io/name=falco --container falco \
    | grep cncf-demo-controller-0 | jq .

export POD=$(kubectl --namespace falco get pods \
    --selector "app.kubernetes.io/name=falco" --no-headers \
    --output custom-columns=":metadata.name" | head -1)

kubectl --namespace falco exec -it $POD -- sh

cat /etc/falco/falco_rules.yaml

exit
```

## Continue The Adventure

* [Managing Secrets in Kubernetes](../secrets/README.md)
