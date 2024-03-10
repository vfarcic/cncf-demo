# Deploy The App Defined As Kustomize To Production With GitOps

## Do

```bash
cat $GITOPS_APP/cncf-demo-kustomize.yaml

cp $GITOPS_APP/cncf-demo-kustomize.yaml apps/cncf-demo.yaml

cd kustomize/overlays/prod

kustomize edit set image $IMAGE=$IMAGE:$TAG

cat kustomization.yaml

cd ../../../

yq --inplace ".[0].value = \"cncf-demo.$DOMAIN\"" \
    kustomize/overlays/prod/ingress.yaml

yq --inplace ".[1].value = \"cncf-demo.$DOMAIN\"" \
    kustomize/overlays/prod/ingress.yaml

yq --inplace ".[2].value = \"$INGRESS_CLASS_NAME\"" \
    kustomize/overlays/prod/ingress.yaml

git add .

git commit -m "cncf-demo v0.0.1"

git push

kubectl --namespace production get all,ingresses

curl "http://cncf-demo.$DOMAIN"
```

## Destroy

* [Destroy](../destroy/rejekts-paris-production.md)
