#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: customer name
# Optional parameters: -
# Usage: ./customers_find_by_name.sh "John DOE"

if [ -z "$1" ]; then
  echo "missing customer name!"
  exit 2
fi

query=''

printf -v  query "\"name\": \"$@\""
./api_customers_listing.sh | grep -B 8 -A 8 -i "$query"
