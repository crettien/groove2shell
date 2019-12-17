#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: the json output of customers listing or find
# Optional parameters: -
# Usage: ./customers_find_by_name.sh "John DOE" | ./customers_extract_id.sh

function help() {
  printf "\033[33m# HELP: customer_extract_id\n\033[0m"
  printf "\033[33m# Expected parameters:\tthe json output of customers listing or find\n\033[0m"
  printf "\033[33m# Optional parameters:\t-\n\033[0m"
  printf "\033[33m# Usage:\t\t./customers_find_by_name.sh \"John DOE\" | ./customers_extract_id.sh\n\033[0m"
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  help
  exit 0
fi

while read line; do
  echo ${line} | grep '"id":' | cut -d':' -f2 | tr -d ', "'
done < /dev/stdin
