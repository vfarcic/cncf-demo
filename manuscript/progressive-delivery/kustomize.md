# Progressive Delivery with Istio and Kustomize

TODO: Intro

## Setup

> Execute the command that follows only if you chose Argo Rollouts.

```sh
yq --inplace ".spec.hosts[0] = \"cncf-demo.$ISTIO_HOST\"" \
    kustomize/overlays/prod/virtual-service.yaml
```

> Execute the command that follows only if you chose Flagger.

```sh
yq --inplace ".spec.service.hosts[0] = \"cncf-demo.$ISTIO_HOST\"" \
    kustomize/overlays/prod/flagger.yaml
```

## Do

> Execute the command that follows only if you chose Argo Rollouts

```bash
yq --inplace ".spec.replicas = 0" kustomize/base/deployment.yaml
```

> Execute the command that follows only if you chose Argo Rollouts.

```sh
cat kustomize/overlays/prod/virtual-service.yaml
```

```sh
cat kustomize/overlays/prod/$PD_APP.yaml
```

> Execute the command that follows only if you chose Argo Rollouts.

```sh
sed -i -e 's/virtual-service-no-pd.yaml/virtual-service.yaml/g' \
    kustomize/overlays/prod/kustomization.yaml
```

```sh
yq --inplace ".resources += \"$PD_APP.yaml\"" \
    kustomize/overlays/prod/kustomization.yaml

git add .

git commit -m "Progressive delivery"

git push

kubectl --namespace production get virtualservices
```

> Wait until VirtualServices `cncf-demo-1` and ``cncf-demo-2` are created.

> Execute the command that follows in a second terminal session (in the same directory)

```sh
source .env
```

> Execute the command that follows in the second terminal session

```sh
hey -z 60m "http://cncf-demo.$ISTIO_HOST"
```

> Execute the command that follows only if you chose Argo Rollouts

```sh
kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```

> Execute the command that follows only if you chose Flagger.

```sh
kubectl --namespace production describe canary cncf-demo
```

```sh
curl "http://cncf-demo.$ISTIO_HOST"

cd kustomize/overlays/prod

kustomize edit set image \
    index.docker.io/vfarcic/cncf-demo=index.docker.io/vfarcic/cncf-demo:v0.0.2

cd ../../../

git add .

git commit -m "Progressive delivery"

git push
```

> Execute the command that follows in a third terminal session (in the same directory)

```sh
source .env
```

> Execute the command that follows in the third terminal session

```sh
for i in {1..20}; do
    curl "http://cncf-demo.$ISTIO_HOST"
done
```

> If you do not see outputs with `v0.0.2`, the rollout did not yet start. Wait for a few moments and try again.

> Execute the command that follows only if you chose Argo Rollouts.

```sh
kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```

> Execute the command that follows only if you chose Flagger.

```sh
kubectl --namespace production get canaries --watch
```

> Press `ctrl+c` to stop watching the rollout once it's finished.

```sh
cd kustomize/overlays/prod

kustomize edit set image \
    index.docker.io/vfarcic/cncf-demo=index.docker.io/vfarcic/cncf-demo:v0.0.3

cd ../../../

git add .

git commit -m "Progressive delivery"

git push
```

> Press `ctrl+c` in the third terminal sesstion to stop watching `hey`.

> Execute the command that follows in the second terminal session

```sh
hey -z 60m "http://cncf-demo.$ISTIO_HOST?fail=true"
```

> Execute the command that follows only if you chose Argo Rollouts.

```sh
kubectl argo rollouts --namespace production \
    get rollout cncf-demo --watch
```

> Execute the command that follows only if you chose Flagger.

```sh
kubectl --namespace production get canaries --watch
```

## Continue The Adventure

* [Cloud Cost](../cost/README.md)
