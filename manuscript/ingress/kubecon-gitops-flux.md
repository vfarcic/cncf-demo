# Ingress For Flux (Weave GitOps)

## Do

```bash
export DOMAIN=$INGRESS_IP.nip.io

gitops create dashboard gitops --password=admin --export | tee infra/weave-gitops-dashboard.yaml

echo "
    ingress:
      className: $INGRESS_CLASS_NAME
      enabled: true
      hosts:
        - host: gitops.$DOMAIN
          paths:
            - path: /
              pathType: ImplementationSpecific" \
    | tee -a infra/weave-gitops-dashboard.yaml

git add .

git commit -m "GitOps"

git push

kubectl --namespace flux-system get helmrelease gitops

echo "http://gitops.$DOMAIN"

# Open it in a browser

# Use `admin` as both the Username and the Password
```

## Continue The Adventure

* [Helm](../app/kubecon-helm.md)
* [Kustomize](../app/kubecon-kustomize.md)
* [Carvel ytt](../app/kubecon-carvel.md)
* [cdk8s](../app/kubecon-cdk8s.md)

