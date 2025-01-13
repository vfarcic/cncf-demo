#!/usr/bin/env nu

def "main apply kubevela" [
    host: string
] {

    vela install

    (
        vela addon enable velaux
            $"domain=($host)"
            gatewayDriver=nginx
    )

    start $"http://($host)"

}