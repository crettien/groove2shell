#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: message id <string>
# Optional parameters: -
# Usage: ./api_attachments_listing.sh '{"message":"1234567"}' #where 1234567 is a message id

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
