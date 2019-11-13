#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: customer email <string>
# Optional parameters: -
# Usage: ./api_customer_find.sh "acme@company.com" #where acme@company.com is an email address

function help() {
  printf "\033[33m# HELP: api_customer_find\n\033[0m"
  printf "\033[33m# Expected parameters:\tcustomer email <string>\n\033[0m"
  printf "\033[33m# Optional parameters:\t-\n\033[0m"
  printf "\033[33m# Usage:\t\t./api_customer_find.sh \"acme@company.com\" #where acme@company.com is an email address\n\033[0m"
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  help
  exit 0
fi

# initilization
source groove_api_key.conf

query=''
separator='?'

# split parameters into query fields
parameters=$1
customer_email=$1
#`echo $parameters | jq -r .customer_email`

# build the query
if [ "x$customer_email" != "xnull" ]; then
  printf -v query "$query""$customer_email"
fi

curl -s "https://api.groovehq.com/v1/customers/$query""$separator""access_token=$access_token" | jq 
