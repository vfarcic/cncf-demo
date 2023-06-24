# Runtime Policies With KubeArmor

TODO: Intro

## Setup

```bash
# TODO: kapp-controller

export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

export REPO_URL=$(git config --get remote.origin.url)

# Execute the command that follows only if you're using Argo CD
yq --inplace ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/kubearmor.yaml

curl -sfL http://get.kubearmor.io/ \
    | sudo sh -s -- -b /usr/local/bin

mkdir kubearmor

karmor install --save

mv kubearmor.yaml kubearmor/.

cat $GITOPS_APP/kubearmor.yaml

cp $GITOPS_APP/kubearmor.yaml infra/.

git add .

git commit -m "KubeArmor"

git push
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

[Managing Secrets](../secrets/README.md)
