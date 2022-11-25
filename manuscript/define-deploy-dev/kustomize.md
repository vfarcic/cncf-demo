# Define And Deploy The App To Dev With Kustomize

TODO: Intro

## Setup

```bash
yq --inplace \
    ".images[0].name = \"$IMAGE\"" \
    kustomize/base/kustomization.yaml

yq --inplace \
    ".images[0].newName = \"$IMAGE\"" \
    kustomize/base/kustomization.yaml

yq --inplace \
    ".spec.rules[0].host = \"dev.cncf-demo.$DOMAIN\"" \
    kustomize/base/ingress.yaml

yq --inplace \
    ".spec.template.spec.containers[0].image = \"$IMAGE\"" \
    kustomize/base/deployment.yaml
```

## Do

```bash
cd kustomize/base

ls -1

cat deployment.yaml

cat service.yaml

cat ingress.yaml

cat kustomization.yaml

kustomize edit set image $IMAGE=$IMAGE:$TAG

cd ../../

kubectl --namespace dev apply --kustomize kustomize/base

echo "http://dev.cncf-demo.$DOMAIN"

# Open it in a browser
```

* If you chose `kbld` to build images, you'll need to point it to the specific manifest with the resource that references the image we want to build. It does not understand Kustomize so it cannot work on the directory level. Moreover, it's ability to generate new manifests with image SHA digests is probably NOT what we want to use with Kustomize which, as we saw, has its own way of defining image tags.

## Continue The Adventure

[Use HTTPS](../https/story.md)

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
kubectl --namespace dev delete --kustomize kustomize/base

yq --inplace ".images[0].newTag = \"latest\"" \
    kustomize/base/kustomization.yaml
```
