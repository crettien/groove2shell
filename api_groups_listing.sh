#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: -
# Optional parameters: -
# Usage: ./api_groups_listing.sh

function help() {
  printf "\033[33m# HELP: api_groups_listing\n\033[0m"
  printf "\033[33m# Expected parameters:\t-\n\033[0m"
  printf "\033[33m# Optional parameters:\t-\n\033[0m"
  printf "\033[33m# Usage:\t\t./api_groups_listing.sh\n\033[0m"
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  help
  exit 0
fi

# initilization
source groove_api_key.conf

curl -s "https://api.groovehq.com/v1/groups/?access_token=$access_token" | jq

