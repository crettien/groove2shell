#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: -
# Optional parameters: -
# Usage: ./api_groups_listing.sh

# initilization
source groove_api_key.conf

curl -s "https://api.groovehq.com/v1/groups/?access_token=$access_token" | jq

