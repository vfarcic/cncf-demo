# Ingress With Envoy And Contour

## Do

```bash
cat $GITOPS_APP/contour.yaml

cp $GITOPS_APP/contour.yaml infra/.

git add . 

git commit -m "Contour"

git push

kubectl --namespace projectcontour get all

export INGRESS_HOSTNAME=$(kubectl --namespace projectcontour \
    get service contour-envoy \
    --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

export INGRESS_IP=$(dig +short $INGRESS_HOSTNAME) 

echo $INGRESS_IP

# Repeat the `export` commands if the output is empty or shows
#   and error (e.g., `NotFound`)

# If the output contains more than one IP, wait for a while 
#   longer, and repeat the `export` commands.

# If the output continues having more than one IP, choose one of
#   them and execute `export INGRESS_IP=[...]` with `[...]`
#   being the selected IP.

export INGRESS_CLASS_NAME=contour
```

## Which GitOps Tool Did You Choose?

* [Argo CD](kubecon-gitops-argocd.md)
* [Flux](kubecon-gitops-flux.md)
* [Carvel kapp-controller](kubecon-gitops-kapp.md)
