#!/usr/bin/env nu

source scripts/get-hyperscaler.nu
source scripts/github.nu
source scripts/kubernetes.nu
source scripts/ingress.nu
source scripts/crossplane.nu
source scripts/kyverno.nu
source scripts/argocd.nu
source scripts/argo-workflows.nu
source scripts/argo-events.nu
source scripts/registry.nu

def main [] {}

# Destroys the IDP chapter
def "main destroy idp" [] {

    kubectl --namespace production delete --filename crossplane/repo.yaml
    
    cd cncf-demo-app

    git pull

    kubectl --namespace production delete --filename apps/

    touch apps/empty

    rm --force apps/*.yaml

    git add .

    git commit -m "Destroy"

    git push

    cd ..

    main delete crossplane

    if $env.HYPERSCALER == "google" {

        gcloud projects delete $env.PROJECT_ID --quiet

    }

    main destroy kubernetes $env.HYPERSCALER

    rm --force --recursive cncf-demo-app

    gh repo delete $"($env.GITHUB_USER)/cncf-demo-app"

}

# Sets up the IDP chapter
def "main setup idp" [] {
    
    rm --force .env

    let hyperscaler = main get hyperscaler

    main create kubernetes $hyperscaler

    main apply ingress contour --hyperscaler $hyperscaler

    kubectl create namespace production

}

# Sets up the IDP chapter
def "main setup idp_crossplane" [
    hyperscaler: string
] {

    let github_data = main get github
    
    (
        main apply crossplane
            --hyperscaler $hyperscaler
            --db true --app true --github true
            --github_user $github_data.user
            --github_token $github_data.token
    )

    if $hyperscaler == "azure" {

        let date_suffix = (date now | format date "%Y%m%d%H%M%S")

        open crossplane/azure-sql.yaml |
            | upsert spec.id $"silly-demo-db-($date_suffix)"
            | save crossplane/azure-sql.yaml --force

        open crossplane/azure-sql-password.yaml |
            | upsert metadata.name $"silly-demo-db-($date_suffix)-password"
            | save crossplane/azure-sql-password.yaml --force

        open crossplane/app.yaml |
            | upsert spec.parameters.db.secret $"silly-demo-db-($date_suffix)"
            | save crossplane/app.yaml --force

    } else {

        open crossplane/app.yaml |
            | upsert spec.parameters.db.secret "silly-demo-db"
            | save crossplane/app.yaml --force

    }

    open crossplane/app.yaml
        | upsert spec.parameters.host $"silly-demo.($env.INGRESS_IP).nip.io"
        | upsert spec.parameters.image $"ghcr.io/($github_data.user)/cncf-demo-app"
        | upsert spec.parameters.tag "FIXME"
        | save crossplane/app.yaml --force

}

def "main setup idp_argo_workflows" [
    github_user: string
    github_pat: string
] {

    let email = input $"(ansi green_bold)Enter ghcr.io registry email \(e.g., viktor@farcic.com\):(ansi reset) "

    (
        main apply argoworkflows
            $github_user $github_pat $email --registry "ghcr.io"
    )

    main apply argoevents

}

def "main setup idp_argocd" [] {

    (
        main apply argocd
            --host_name $"argocd.($env.INGRESS_HOST)"
            --ingress_class_name "contour"
            --apply_apps false
    )

    open argocd/apps-idp.yaml
        | upsert spec.source.repoURL $"https://github.com/($env.GITHUB_USER)/cncf-demo-app"
        | save argocd/apps-idp.yaml --force

}
