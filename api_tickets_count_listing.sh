#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: -
# Optional parameters: mailbox id <string> or mailbox email address <string>
# Usage: ./api_tickets_count_listing.sh
#        ./api_tickets_count_listing.sh '{"mailbox":"1234567"}' #where 1234567 is a mailbox id
#        ./api_tickets_count_listing.sh '{"mailbox":"acme@company.com"}' #where acme@company.com is a mailbox email address

function help() {
  printf "\033[33m# HELP: api_tickets_count_listing\n\033[0m"
  printf "\033[33m# Expected parameters:\t-\n\033[0m"
  printf "\033[33m# Optional parameters:\tmailbox id <string> or mailbox email address <string>\n\033[0m"
  printf "\033[33m# Usage:\t\t./api_tickets_count_listing.sh\n\033[0m"
  printf "\033[33m# Usage:\t\t./api_tickets_count_listing.sh '{\"mailbox\":\"1234567\"}' #where 1234567 is a mailbox id\n\033[0m"
  printf "\033[33m# Usage:\t\t./api_tickets_count_listing.sh '{\"mailbox\":\"acme@company.com\"}' #where acme@company.com is a mailbox email address\n\033[0m"
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
mailbox=`echo $parameters | jq -r .mailbox`

# build the query
if [ "x$mailbox" != "xnull" ]; then
  printf -v query "$query""$separator""mailbox=$mailbox"
  separator='&'
fi

curl -s "https://api.groovehq.com/v1/tickets/count/$query""$separator""access_token=$access_token" | jq 
