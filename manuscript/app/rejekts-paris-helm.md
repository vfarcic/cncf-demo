# Deploy The App Defined As Helm Chart To Production With GitOps

## Do

```bash
cat $GITOPS_APP/cncf-demo-helm.yaml

cp $GITOPS_APP/cncf-demo-helm.yaml apps/cncf-demo.yaml

# Execute the command that follows only if you are using Argo CD
yq --inplace ".spec.source.helm.parameters[0].value = \"$TAG\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Argo CD
yq --inplace ".spec.source.helm.parameters[1].value = \"cncf-demo.$DOMAIN\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Argo CD
yq --inplace ".spec.source.helm.parameters[2].value = \"$INGRESS_CLASS_NAME\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Flux
yq --inplace ".spec.values.image.tag = \"v0.0.1\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Flux
yq --inplace \
    ".spec.values.ingress.host = \"cncf-demo.$DOMAIN\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Flux
yq --inplace \
    ".spec.values.ingress.className = \"$INGRESS_CLASS_NAME\"" \
    apps/cncf-demo.yaml

# Execute the command that follows only if you are using Carvel
#   kapp-controller.
echo "
---
apiVersion: v1
kind: Secret
metadata:
  name: cncf-demo-values
  namespace: carvel-apps
stringData:
  cncf-demo-values.yaml: |
    image:
      tag: $TAG
    ingress:
      host: cncf-demo.$DOMAIN
      className: $INGRESS_CLASS_NAME
    tls:
      enabled: true
spec:
  source:
    repoURL: https://github.com/devopsparadox/cncf-demo.git" \
    | tee -a apps/cncf-demo.yaml

cat apps/cncf-demo.yaml

git add .

git commit -m "cncf-demo v0.0.1"

git push

kubectl --namespace production get all,ingresses

curl "http://cncf-demo.$DOMAIN"
```

## Destroy

* [Destroy](../destroy/rejekts-paris-production)
