#!/usr/bin/env nu

def "main apply argoevents" [] {

    kubectl create namespace argo-events

    (
        kubectl apply
            --filename https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install.yaml
    )
    
    (
        kubectl apply
            --filename https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install-validating-webhook.yaml
    )

}
