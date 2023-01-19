# Ingress With NGINX

TODO: Intro

## Do

```bash
export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cat $GITOPS_APP/nginx.yaml

cp $GITOPS_APP/nginx.yaml infra/.

git add . 

git commit -m "NGINX"

git push

# If NOT EKS
export INGRESS_IP=$(kubectl --namespace ingress-nginx \
    get service ingress-nginx-controller \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

# If EKS
export INGRESS_HOSTNAME=$(kubectl --namespace ingress-nginx \
    get service ingress-nginx-controller \
    --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

# If EKS
export INGRESS_IP=$(dig +short $INGRESS_HOSTNAME) 

echo $INGRESS_IP

# Repeat the `export` commands if the output is empty

# If the output contains more than one IP, wait for a while 
#   longer, and repeat the `export` commands.

# If the output continues having more than one IP, choose one of
#   them and execute `export INGRESS_IP=[...]` with `[...]`
#   being the selected IP.

yq --inplace ".production.ingress.ip = \"$INGRESS_IP\"" \
    settings.yaml

yq --inplace ".production.ingress.className = \"nginx\"" \
    settings.yaml
```

## Which GitOps Tool Did You Choose?

[Argo CD](gitops-argocd.md)
[Flux](gitops-flux.md)
