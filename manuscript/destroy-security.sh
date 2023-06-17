#!/bin/sh
set -e

source .env

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Destroy everything created in the Security chapter'

gum confirm '
Are you ready to start?
Feel free to say "No" and inspect the script if you prefer setting up resources manually.
' || exit 0

################
# Hyperscalers #
################

if [[ "$HYPERSCALER" == "google" ]]; then

    gcloud projects delete ${PROJECT_ID} --quiet

fi
