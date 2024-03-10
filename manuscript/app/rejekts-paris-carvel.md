# Deploy The App Defined As Carvel ytt To Production With GitOps

## Do

```bash
cat $GITOPS_APP/cncf-demo-ytt.yaml

cp $GITOPS_APP/cncf-demo-ytt.yaml apps/cncf-demo.yaml

yq --inplace ".ingress.host = \"cncf-demo.$DOMAIN\"" \
    ytt/values-prod.yaml

yq --inplace ".ingress.className = \"$INGRESS_CLASS_NAME\"" \
    ytt/values-prod.yaml

yq --inplace ".image.tag = \"$TAG\"" ytt/values-prod.yaml

cat ytt/values-prod.yaml

ytt --file ytt/schema.yaml --file ytt/resources \
    --data-values-file ytt/values-prod.yaml \
    | tee yaml/prod/app.yaml

git add .

git commit -m "cncf-demo v0.0.1"

git push

kubectl --namespace production get all,ingresses

curl -i "http://cncf-demo.$DOMAIN"
```

## Destroy

* [Destroy](../destroy/rejekts-paris-production.md)
