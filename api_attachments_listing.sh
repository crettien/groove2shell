#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: message id <string>
# Optional parameters: -
# Usage: ./api_attachments_listing.sh '{"message":"1234567"}' #where 1234567 is a message id

function help() {
  printf "\033[33m# HELP: api_attachments_listing\n\033[0m"
  printf "\033[33m# Expected parameters:\tmessage id <string>\n\033[0m"
  printf "\033[33m# Optional parameters:\t-\n\033[0m"
  printf "\033[33m# Usage:\t\t./api_attachments_listing.sh '{\"message\":\"1234567\"}' #where 1234567 is a message id\n\033[0m"
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
message=`echo $parameters | jq -r .message`

# build the query
if [ "x$message" != "xnull" ]; then
  printf -v query "$query""$separator""message=$message"
  separator='&'
fi

curl -s "https://api.groovehq.com/v1/attachments/$query""$separator""access_token=$access_token" | jq
