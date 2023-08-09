# Runtime Policies With KubeArmor

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
# TODO: kapp-controller
# TODO: Flux
chmod +x manuscript/runtime-policies/kubearmor.sh

./manuscript/runtime-policies/kubearmor.sh
```

## Do

```bash
export POD=$(kubectl --namespace production get pods \
    --selector app.kubernetes.io/name=cncf-demo \
    --output jsonpath='{.items[0].metadata.name}')

kubectl --namespace production exec -it $POD -- ls -l /

# If it says that `executable file not found in $PATH`, the image
#   is probably based on `scratch` so there is nothing to
#   protect.
# If that's the case, you can skip the rest of this section.

kubectl annotate namespace production \
    kubearmor-file-posture=block --overwrite

cat policies/kubearmor.yaml

cp policies/kubearmor.yaml infra/runtime-policies.yaml

git add .

git commit -m "KubeArmor"

git push

kubectl --namespace production get kubearmorpolicies

# Wait until the policy is created

kubectl --namespace production exec -it $POD -- ls -l /
```

## Continue The Adventure

* [Managing Secrets](../secrets/README.md)
