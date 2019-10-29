#!/bin/bash

# initilization
source groove_api_key.conf

query=''
separator='?'

# split parameters into query fields
parameters=$1
assignee=`echo $parameters | jq -r .assignee`
customer=`echo $parameters | jq -r .customer`
page=`echo $parameters | jq -r .page`
per_page=`echo $parameters | jq -r .per_page`
state=`echo $parameters | jq -r .state`
folder=`echo $parameters | jq -r .folder`

# build the query
if [ "x$assignee" != "xnull" ]; then
  printf -v query "$separator""assignee=$assignee"
  separator='&'
fi
if [ "x$customer" != "xnull" ]; then
  printf -v query "$query""$separator""customer=$customer"
  separator='&'
fi
if [ "x$page" != "xnull" ]; then
  printf -v query "$query""$separator""page=$page"
  separator='&'
fi
if [ "x$per_page" != "xnull" ]; then
  printf -v query "$query""$separator""per_page=$per_page"
  separator='&'
fi
if [ "x$state" != "xnull" ]; then
  printf -v query "$query""$separator""state=$state"
  separator='&'
fi
if [ "x$folder" != "xnull" ]; then
  printf -v query "$query""$separator""folder=$folder"
  separator='&'
fi

curl -s "https://api.groovehq.com/v1/tickets/$query""$separator""access_token=$access_token" | jq 
