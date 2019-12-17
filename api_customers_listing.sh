#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: -
# Optional parameters: page <integer>
#                      per_page <integer>
# Usage: ./api_customers_listing.sh
#        ./api_customers_listing.sh '{"page":1}' #where 1 is a page number
#        ./api_customers_listing.sh '{"per_page":50}' #where 50 is a number of customers to display per page
#        ./api_customers_listing.sh '{"page":3,"per_page":30}'

function help() {
  printf "\033[33m# HELP: api_customers_listing\n\033[0m"
  printf "\033[33m# Expected parameters:\t-\n\033[0m"
  printf "\033[33m# Optional parameters:\tpage <integer>\n\033[0m"
  printf "\033[33m# \t\t\tper_page <integer>\n\033[0m"
  printf "\033[33m# Usage:\t\t./api_customers_listing.sh\n\033[0m"
  printf "\033[33m# \t\t\t./api_customers_listing.sh '{\"page\":1}' #where 1 is a page number\n\033[0m"
  printf "\033[33m# \t\t\t./api_customers_listing.sh '{\"per_page\":50}' #where 50 is a number of customers to display per page\n\033[0m"
  printf "\033[33m# \t\t\t./api_customers_listing.sh '{\"page\":1,\"per_page\":50}'\n\033[0m"
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
page=`echo $parameters | jq -r .page`
per_page=`echo $parameters | jq -r .per_page`

# build the query
if [ "x$page" != "xnull" ]; then
  printf -v query "$query""$separator""page=$page"
  separator='&'
fi
if [ "x$per_page" != "xnull" ]; then
  printf -v query "$query""$separator""per_page=$per_page"
  separator='&'
fi
curl -s "https://api.groovehq.com/v1/customers/$query""$separator""access_token=$access_token" | jq
