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
|px              |Yes                  |'https://docs.px.dev/installing-pixie/install-schemes/cli'|

" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

px auth login

px deploy --cluster_name dot -y
