#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: -
# Optional parameters: group id <string>
# Usage: ./api_agents_listing.sh
#        ./api_agents_listing.sh '{"group":"1234567"}' #where 1234567 is a group id


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
