#!/usr/bin/env nu

def "main apply flux" [
    repo: string
] {

    let git_url = git config --get remote.origin.url

    let github_data = main get github

    $env.GITHUB_TOKEN = $github_data.token

    (
        flux bootstrap github --owner $github_data.user
            --repository $repo --branch main
            --path "./infra" --personal
    )

}
