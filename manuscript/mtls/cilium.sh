#!/bin/sh
set -e

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the Mutual TLS (mTLS) And Network Policies With Cilium And SPIFFE chapter.'

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
|helm            |Yes                  |'https://helm.sh/docs/intro/install/'              |
|kubectl         |Yes                  |'https://kubernetes.io/docs/tasks/tools/#kubectl'  |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0

#########
# Setup #
#########

helm upgrade cilium cilium/cilium --namespace kube-system \
    --set authentication.mutual.spire.enabled=true \
    --set authentication.mutual.spire.install.enabled=true \
    --reuse-values --wait

kubectl --namespace kube-system \
    rollout restart deployment/cilium-operator

kubectl --namespace kube-system rollout restart ds/cilium
