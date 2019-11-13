#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: -
# Optional parameters: mailbox id <string> or mailbox email address <string>
# Usage: ./api_folders_listing.sh
#        ./api_folders_listing.sh '{"mailbox":"1234567"}' #where 1234567 is a mailbox id
#        ./api_folders_listing.sh '{"mailbox":"acme@company.com"}' #where acme@company.com is a mailbox email address

function help() {
  printf "\033[33m# HELP: api_folders_listing\n\033[0m"
  printf "\033[33m# Expected parameters:\t-\n\033[0m"
  printf "\033[33m# Optional parameters:\tmailbox id <string> or mailbox email address <string>\n\033[0m"
  printf "\033[33m# Usage:\t\t./api_folders_listing.sh\n\033[0m"
  printf "\033[33m# \t\t\t./api_folders_listing.sh \"1234567\" #where acme@company.com is a mailbox id\n\033[0m"
  printf "\033[33m# \t\t\t./api_folders_listing.sh \"acme@company.com\" #where acme@company.com is an email address\n\033[0m"
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
if [ "x$message" != "xnull" ]; then
  printf -v query "$query""$separator""mailbox=$mailbox"
  separator='&'
fi

curl -s "https://api.groovehq.com/v1/folders/$query""$separator""access_token=$access_token" | jq
