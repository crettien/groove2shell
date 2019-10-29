#!/bin/bash

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

curl -s "https://api.groovehq.com/v1/messages/$query""$separator""access_token=$access_token" | jq 
