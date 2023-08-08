# Define And Deploy The App To Dev With Kustomize

Kustomize is a template-free way to customize application configuration. It is natively built into *kubectl* as `apply -k`, and it's also available as a standalone binary for integration into other services.

In this section, you will inspect and/or modify the following files:

```bash
kustomize/
├── base
│   ├── deployment.yaml
│   ├── ingress.yaml
│   ├── kustomization.yaml
│   └── service.yaml
└── overlays
    └── dev
        └── ingress.yaml
```

## Setup

```bash
chmod +x manuscript/define-deploy-dev/kustomize.sh

./manuscript/define-deploy-dev/kustomize.sh
```

## Do

```bash
ls -1 kustomize/base

cat kustomize/base/deployment.yaml

cat kustomize/base/service.yaml

cat kustomize/base/ingress.yaml

cat kustomize/base/kustomization.yaml

cat kustomize/overlays/dev/ingress.yaml

cd kustomize/overlays/dev

cat kustomization.yaml

kustomize edit set image $IMAGE=$IMAGE:$TAG

cat kustomization.yaml

cd ../../../

kubectl --namespace dev apply --kustomize kustomize/overlays/dev

echo "http://cncf-demo-dev.$DOMAIN"

# Open it in a browser
```

* If you chose `kbld` to build images, you'll need to point it to the specific manifest with the resource that references the image we want to build. It does not understand Kustomize so it cannot work on the directory level. Moreover, it's ability to generate new manifests with image SHA digests is probably NOT what we want to use with Kustomize which, as we saw, has its own way of defining image tags.

## Continue The Adventure

* [Use HTTPS](../https/README.md)
