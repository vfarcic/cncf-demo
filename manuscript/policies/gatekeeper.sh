#!/bin/sh
set -e

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|git             |Yes                  |'https://git-scm.com/book/en/v2/Getting-Started-Installing-Git'|
|kubectl         |Yes                  |'https://kubernetes.io/docs/tasks/tools/#kubectl'  |
|helm            |Yes                  |'https://helm.sh/docs/intro/install/'              |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

rm -f apps/cncf-demo.yaml

set +e
git add .

git commit -m "CNCF Demo"

git push
set -e

# Gatekeeper causes issues with Argo CD (not sure about Flux),
#   so we'll install it manually.

helm repo add gatekeeper \
    https://open-policy-agent.github.io/gatekeeper/charts

helm repo update

helm upgrade --install gatekeeper gatekeeper/gatekeeper \
    --namespace gatekeeper-system --create-namespace --wait

