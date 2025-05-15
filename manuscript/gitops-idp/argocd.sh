#!/bin/sh

kubectl --namespace production delete \
    --filename cncf-demo-app/apps/silly-demo.yaml

open "http://argocd.$INGRESS_HOST"

cat argocd/apps-idp.yaml

kubectl --namespace production get all,ingresses

kubectl apply --filename argocd/apps-idp.yaml

kubectl --namespace production get all,ingresses

