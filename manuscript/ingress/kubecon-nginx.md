# Ingress With NGINX

## Do

```bash
cat $GITOPS_APP/nginx.yaml

cp $GITOPS_APP/nginx.yaml infra/.

git add . 

git commit -m "NGINX"

git push

kubectl --namespace ingress-nginx get all

export INGRESS_HOSTNAME=$(kubectl --namespace ingress-nginx get service ingress-nginx-controller --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

export INGRESS_IP=$(dig +short $INGRESS_HOSTNAME) 

echo $INGRESS_IP

# Repeat the `export` commands if the output is empty

# If the output contains more than one IP, wait for a while 
#   longer, and repeat the `export` commands.

# If the output continues having more than one IP, choose one of
#   them and execute `export INGRESS_IP=[...]` with `[...]`
#   being the selected IP.

export INGRESS_CLASS_NAME=nginx

export DOMAIN=$INGRESS_IP.nip.io
```

## Which GitOps Tool Did You Choose?

* [Argo CD](kubecon-gitops-argocd.md)
* [Flux](kubecon-gitops-flux.md)
* [Carvel kapp-controller](kubecon-gitops-kapp.md)
