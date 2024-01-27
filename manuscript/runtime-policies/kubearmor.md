# Runtime Policies With KubeArmor

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
# TODO: kapp-controller
chmod +x manuscript/runtime-policies/kubearmor.sh

./manuscript/runtime-policies/kubearmor.sh
```

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

# KubeArmor might fail to work depending on the OS, as is the
#   case of AKS Azure cluster created in this demo if you
#   followed the setup instructions for Azure.
# Check whether the OS of the cluster is one of the supported
#   ones in
#   https://docs.kubearmor.io/kubearmor/quick-links/support_matrix#kubernetes-support-matrix.
```

## Continue The Adventure

* [Managing Secrets in Kubernetes](../secrets/README.md)
