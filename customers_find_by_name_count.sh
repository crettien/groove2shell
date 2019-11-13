#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: customer name
# Optional parameters: -
# Usage: ./customers_find_by_name_count.sh "John DOE"

function help() {
  printf "\033[33m# HELP: customers_find_by_name_count\n\033[0m"
  printf "\033[33m# Expected parameters:\tcustomer name\n\033[0m"
  printf "\033[33m# Optional parameters:\t-\n\033[0m"
  printf "\033[33m# Usage:\t\t./customers_find_by_name_count.sh \"John DOE\"\n\033[0m"
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  help
  exit 0
fi

if [ -z "$1" ]; then
  echo "missing customer name!"
  exit 2
fi

query=''

printf -v  query "\"name\": \"$@\""
count=`./api_customers_listing.sh | grep -B 8 -A 8 -i "$query" | grep "$query" | wc -l`
echo $count
