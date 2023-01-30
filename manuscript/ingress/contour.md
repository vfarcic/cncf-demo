# Ingress With Envoy And Contour

TODO: Intro

## Setup

```bash
export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)
```

## Do

```bash
cat $GITOPS_APP/contour.yaml

cp $GITOPS_APP/contour.yaml infra/.

git add . 

git commit -m "Contour"

git push

# If NOT EKS
export INGRESS_IP=$(kubectl --namespace projectcontour \
    get service contour-envoy \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

# If EKS
export INGRESS_HOSTNAME=$(kubectl --namespace projectcontour \
    get service contour-envoy \
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

yq --inplace ".production.ingress.className = \"contour\"" \
    settings.yaml
```

## Which GitOps Tool Did You Choose?

[Argo CD](gitops-argocd.md)
[Flux](gitops-flux.md)
