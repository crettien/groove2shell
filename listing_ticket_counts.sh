#!/bin/bash

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
