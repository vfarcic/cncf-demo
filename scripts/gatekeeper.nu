#!/usr/bin/env nu

def "main apply gatekeeper" [] {

    (
        helm repo add gatekeeper
            https://open-policy-agent.github.io/gatekeeper/charts
    )

    helm repo update

    (
        helm upgrade --install gatekeeper gatekeeper/gatekeeper 
            --namespace gatekeeper-system --create-namespace
            --wait
    )

}
