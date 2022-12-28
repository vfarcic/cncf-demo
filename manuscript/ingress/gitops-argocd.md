# Ingress For Argo CD

TODO: Intro

## Do

```bash
# Replace `[...]` with the domain (e.g., sillydemo.com)
export DOMAIN=[...]

echo $INGRESS_HOST

# Configure DNS for the following subdomains:
# - argocd

cat argocd/helm-values.yaml

yq --inplace ".server.ingress.enabled = true" \
    argocd/helm-values.yaml

yq --inplace ".server.ingress.ingressClassName = \"$INGRESS_CLASS_NAME\"" \
    argocd/helm-values.yaml

yq --inplace ".server.ingress.hosts[0] = \"argocd.$DOMAIN\"" \
    argocd/helm-values.yaml

yq --inplace ".server.ingress.tls[0].hosts[0] = \"argocd.$DOMAIN\"" \
    argocd/helm-values.yaml

yq --inplace ".server.ingress.tls[0].secretName = \"argocd\"" \
    argocd/helm-values.yaml

cat argocd/helm-values.yaml

helm upgrade --install argocd argo/argo-cd \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

cat argocd/certificate.yaml

yq --inplace \
    ".spec.commonName = \"argocd.$DOMAIN\"" \
    argocd/certificate.yaml

yq --inplace \
    ".spec.dnsNames[0] = \"argocd.$DOMAIN\"" \
    argocd/certificate.yaml

cat argocd/certificate.yaml

cp argocd/certificate.yaml infra/.

git add .

git commit -m "Certificate"

git push

echo "https://argocd.$DOMAIN"

# Open it in a browser

# Login with the following credentials:
# - Username: admin
# - Password: admin123
```

## Which GitOps Tool Did You Choose?

[Argo CD](gitops-argocd.md)
[Something Else](gitops-else.md)
