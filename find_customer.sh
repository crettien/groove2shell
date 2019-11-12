#!/bin/bash

# initilization
source groove_api_key.conf

query=''
separator='?'

# split parameters into query fields
parameters=$1
echo $parameters
customer_email=`echo $parameters | jq -r .customer_email`

# build the query
if [ "x$customer_email" != "xnull" ]; then
  printf -v query "$query""$customer_email"
fi

echo "https://api.groovehq.com/v1/customers/$query""$separator""access_token=$access_token"

curl -s "https://api.groovehq.com/v1/customers/$query""$separator""access_token=$access_token" | jq 
