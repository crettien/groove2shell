#!/bin/bash

# initilization
source groove_api_key.conf

query=''
separator='?'

# split parameters into query fields
parameters=$1
group=`echo $parameters | jq -r .group`

# build the query
if [ "x$group" != "xnull" ] && [ ! -z $group ]; then
  printf -v query "$query""$separator""group=$group"
  separator='&'
fi

curl -s "https://api.groovehq.com/v1/agents/$query""$separator""access_token=$access_token" | jq
