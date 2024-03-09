# Ingress For Argo CD

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/ingress/gitops-argocd.sh

./manuscript/ingress/gitops-argocd.sh

source .env
```

## Do

```bash
cat argocd/helm-values.yaml

yq --inplace ".server.ingress.enabled = true" \
    argocd/helm-values.yaml

yq --inplace \
    ".server.ingress.ingressClassName = \"$INGRESS_CLASS_NAME\"" \
    argocd/helm-values.yaml

yq --inplace ".server.ingress.hostname = \"gitops.$DOMAIN\"" \
    argocd/helm-values.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
yq --inplace \
    ".server.ingress.tls[0].hosts[0] = \"gitops.$DOMAIN\"" \
    argocd/helm-values.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
yq --inplace ".server.ingress.tls[0].secretName = \"argocd\"" \
    argocd/helm-values.yaml

cat argocd/helm-values.yaml

helm upgrade --install argocd argo-cd \
    --repo https://argoproj.github.io/argo-helm \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
cat argocd/certificate.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
yq --inplace ".spec.commonName = \"gitops.$DOMAIN\"" \
    argocd/certificate.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
yq --inplace ".spec.dnsNames[0] = \"gitops.$DOMAIN\"" \
    argocd/certificate.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
cat argocd/certificate.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
cp argocd/certificate.yaml infra/.

git add .

git commit -m "Certificate"

git push

# Change `https` to `http` if you chose to use `nip.io` instead
#   of a "real" domain
echo "https://gitops.$DOMAIN"

# Open it in a browser

# Login with the following credentials:
# - Username: admin
# - Password: admin123
```

## Continue The Adventure

* [Deploy The App](../app/README.md)

