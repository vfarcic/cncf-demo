# Runtime Policies With KubeArmor

## Do

```bash
kubectl --namespace production exec -it cncf-demo-controller-0 \
    -- ls -l /

kubectl annotate namespace production \
    kubearmor-file-posture=block --overwrite

cat policies/kubearmor.yaml

cp policies/kubearmor.yaml infra/runtime-policies.yaml

git add .

git commit -m "KubeArmor"

git push

kubectl --namespace production get kubearmorpolicies

# Wait until the policy is created

kubectl --namespace production exec -it cncf-demo-controller-0 \
    -- ls -l /
```

## What Is Your Choice?

* [External Secrets Operator (ESO)](../secrets/kubecon-paris-eso.md)
* Secrets Store CSI Driver (SSCSID)
