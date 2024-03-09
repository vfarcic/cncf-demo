# Ingress With NGINX

## Do

```bash
cp $GITOPS_APP/nginx.yaml infra/.

git add . 

git commit -m "NGINX"

git push

cat $GITOPS_APP/nginx.yaml

kubectl --namespace ingress-nginx get all

# Wait until Service is created and it got External IP

export INGRESS_HOSTNAME=$(kubectl --namespace ingress-nginx \
    get service ingress-nginx-controller \
    --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

export INGRESS_IP=$(dig +short $INGRESS_HOSTNAME) 

echo $INGRESS_IP

# Repeat the `export` commands if the output is empty

# If the output contains more than one IP, wait for a while 
#   longer, and repeat the `export` commands.

# If the output continues having more than one IP, choose one of
#   them and execute `export INGRESS_IP=[...]` with `[...]`
#   being the selected IP.
```

## Which GitOps Tool Did You Choose?

* [Argo CD](rejekts-paris-gitops-argocd.md)
* [Flux](rejekts-paris-gitops-flux.md)
* [Carvel kapp-controller](rejekts-paris-gitops-kapp.md) (pending)
