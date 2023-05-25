#!/bin/sh
set -e

echo "
## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|odo CLI         |Yes                  |'https://odo.dev/docs/overview/installation'       |
" | gum format

gum confirm "
Do you have those tools installed?
" || exit 0
