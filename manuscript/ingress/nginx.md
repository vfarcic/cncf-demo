# Ingress With NGINX

TODO: Intro

## Do

```bash
# If you created the cluster with Crossplane, NGINX Ingress is
#   already installed

# TODO: Install NGINX Ingress if the cluster was created with Cluster API

export INGRESS_CLASS_NAME=nginx

# If NOT EKS
export INGRESS_HOST=$(kubectl --namespace ingress-nginx \
    get svc production-ingress-ingress-nginx-controller \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

# If EKS
export INGRESS_HOST=$(kubectl --namespace ingress-nginx \
    get svc production-ingress-ingress-nginx-controller \
    --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

echo $INGRESS_HOST

# Repeat the `export` commands if the output is empty

# If the output contains more than one IP, wait for a while
#   longer, and repeat the `export` commands.

# If the output continues having more than one IP, choose one of
#   them and execute `export INGRESS_HOST=[...]` with `[...]`
#   being the selected IP.
```

## Which GitOps Tool Did You Choose?

[Argo CD](gitops-argocd.md)
[Something Else](gitops-else.md)
