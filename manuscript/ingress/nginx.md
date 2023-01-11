# Ingress With NGINX

TODO: Intro

## Do

```bash
cat flux/nginx.yaml

cp argocd/nginx.yaml infra/.

git add . 

git commit -m "Contour"

git push

# If NOT EKS
export INGRESS_HOST=$(kubectl --namespace ingress-nginx \
    get svc ingress-nginx-controller \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

# If EKS
export INGRESS_HOSTNAME=$(kubectl --namespace ingress-nginx \
    get svc ingress-nginx-controller \
    --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

# If EKS
export INGRESS_HOST=$(dig +short $INGRESS_HOSTNAME) 

echo $INGRESS_HOST

# Repeat the `export` commands if the output is empty

# If the output contains more than one IP, wait for a while 
#   longer, and repeat the `export` commands.

# If the output continues having more than one IP, choose one of
#   them and execute `export INGRESS_HOST=[...]` with `[...]`
#   being the selected IP.

export INGRESS_CLASS_NAME=nginx
```

## Which GitOps Tool Did You Choose?

[Argo CD](gitops-argocd.md)
[Flux](gitops-flux.md)
