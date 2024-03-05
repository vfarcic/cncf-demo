# Runtime Policies With Falco

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

## What Is Your Choice?

* [External Secrets Operator (ESO)](../secrets/kubecon-paris-eso.md)
* [Secrets Store CSI Driver (SSCSID)](../secrets/kubecon-paris-sscsid.md)
