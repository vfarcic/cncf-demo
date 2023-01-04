# Ingress For Argo CD

TODO: Intro

## Do

```bash
# Replace `[...]` with the domain (e.g., sillydemo.com).
# If you do not have a domain, replace `[...]` with
#   `$INGRESS_HOST.nip.io`.
# If you do choose to use `nip.io` instead of a "real" domain,
#   beware that:
#   - when opening an application in a browser, you will have to
#     allow insecure connections.
#   - when executing `curl` commands, you will have to add the
#     `--insecure` flag.
#   - you will NOT be able to choose Harbor as container image
#     registry.
export DOMAIN=[...]

echo $INGRESS_HOST

# Configure DNS for the following subdomains (skip this step if
#   you chose to use `nip.io` instead of a "real" domain):
# - argocd

dig +short argocd.$DOMAIN

# Repeat the previous command if the output is NOT the IP address
#   of the Ingress controller.

cat argocd/helm-values.yaml

yq --inplace ".server.ingress.enabled = true" \
    argocd/helm-values.yaml

yq --inplace ".server.ingress.ingressClassName = \"$INGRESS_CLASS_NAME\"" \
    argocd/helm-values.yaml

yq --inplace ".server.ingress.hosts[0] = \"argocd.$DOMAIN\"" \
    argocd/helm-values.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
yq --inplace ".server.ingress.tls[0].hosts[0] = \"argocd.$DOMAIN\"" \
    argocd/helm-values.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
yq --inplace ".server.ingress.tls[0].secretName = \"argocd\"" \
    argocd/helm-values.yaml

cat argocd/helm-values.yaml

helm upgrade --install argocd argo/argo-cd \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

cat argocd/certificate.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
yq --inplace ".spec.commonName = \"argocd.$DOMAIN\"" \
    argocd/certificate.yaml

# Skip this step if you chose to use `nip.io` instead of a
#   "real" domain
yq --inplace ".spec.dnsNames[0] = \"argocd.$DOMAIN\"" \
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
echo "https://argocd.$DOMAIN"

# Open it in a browser

# Login with the following credentials:
# - Username: admin
# - Password: admin123
```

## Continue The Adventure

[Deploy The App](../app/story.md)

