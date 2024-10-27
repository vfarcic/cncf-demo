#!/bin/sh
set -e

#########
# Setup #
#########

px auth login

px deploy --cluster_name dot -y
