#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: customer email <string>
# Optional parameters: -
# Usage: ./api_customer_find.sh "acme@company.com" #where acme@company.com is an email address

# initilization
source groove_api_key.conf

query=''
separator='?'

# split parameters into query fields
parameters=$1
customer_email=$1
#`echo $parameters | jq -r .customer_email`

# build the query
if [ "x$customer_email" != "xnull" ]; then
  printf -v query "$query""$customer_email"
fi

curl -s "https://api.groovehq.com/v1/customers/$query""$separator""access_token=$access_token" | jq 
