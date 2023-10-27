# Ingress For Flux (Weave GitOps)

TODO: Intro

## Setup

* Install [gitops CLI](https://docs.gitops.weave.works/docs/installation/weave-gitops/#gitops-cli)

## Do

```bash
export INGRESS_IP=$(yq ".production.ingress.ip" settings.yaml)

# Replace `[...]` with the domain (e.g., sillydemo.com).
# If you do not have a domain, replace `[...]` with
#   `$INGRESS_IP.nip.io`.
# If you do choose to use `nip.io` instead of a "real" domain,
#   beware that:
#   - when opening an application in a browser, you will have to
#     allow insecure connections.
#   - when executing `curl` commands, you will have to add the
#     `--insecure` flag.
#   - you will NOT be able to choose Harbor as container image
#     registry.
export DOMAIN=[...]

yq --inplace ".production.domain = \"$DOMAIN\"" settings.yaml

# Configure DNS for the following subdomains (skip this step if
#   you chose to use `nip.io` instead of a "real" domain):
# - gitops

dig +short gitops.$DOMAIN

# Repeat the previous command if the output is NOT the IP address
#   of the Ingress controller.

gitops create dashboard gitops --password=admin --export \
    | tee infra/weave-gitops-dashboard.yaml

export INGRESS_CLASS_NAME=$(\
  yq ".production.ingress.className" settings.yaml)

echo "
    ingress:
      className: $INGRESS_CLASS_NAME
      enabled: true
      hosts:
        - host: gitops.$DOMAIN
          paths:
            - path: /
              pathType: ImplementationSpecific" \
    | tee -a infra/weave-gitops-dashboard.yaml

git add .

git commit -m "GitOps"

git push

kubectl --namespace flux-system get helmrelease gitops

echo "http://gitops.$DOMAIN"

# Open it in a browser

# Use `admin` as both the Username and the Password
```

## Continue The Adventure

* [Deploy The App](../app/README.md)

