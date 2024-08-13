#!/usr/bin/env nu

def header [text] {
    mut border = "####"
    for n in 1..($text | str length) {
        $border = $border + "#"
    }
    print $"(ansi purple_bold)
    ($border)
    # ($text) #
    ($border)
    (ansi reset)"
}

def start-script [] {
    let cont = [Yes No]
    | input list $"(ansi green_bold)Are you ready to start?(ansi reset)
Select (ansi yellow_bold)Yes(ansi reset) only if you did NOT follow the story from the start \(if you jumped straight into this chapter).
Feel free to say (ansi yellow_bold)No(ansi reset) and inspect the script if you prefer setting up resources manually(ansi yellow_bold)"
    if $cont == No { print exit }
}
ansi reset

def get-hyperscaler [] {
    let hyperscaler = [google aws azure]
        | input list $"(ansi green_bold)Which Hyperscaler do you want to use?(ansi yellow_bold)"

    $"export HYPERSCALER=($hyperscaler)\n" | save --append .env

    open settings.yaml
        | upsert hyperscaler $hyperscaler
        | save settings.yaml --force

    $hyperscaler
}
