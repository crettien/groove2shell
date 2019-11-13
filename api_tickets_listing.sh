#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: -
# Optional parameters: assignee email <string> agent email address or "unassigned"
#                      customer email or customer id <string> returns tickets belonging to the specified customer
#                      page <integer> the page number
#                      per_page <integer> The number of messages to return per page (max 50)
#                      state <string> returns tickets with the specified state only ("unread", "opened", "pending", "closed", "spam")
#                      folder <integer> the ID of a folder to filter by
# Usage: ./api_tickets_listing.sh
#        ./api_tickets_listing.sh '{"assignee":"john.doe@company.com"}' #where john.doe@company.com is an agent's email address
#        ./api_tickets_listing.sh '{"customer":"acme@company.com"}' #where acme@company.com is a company's email address
#        ./api_tickets_listing.sh '{"page":3}' #where 3 is the page to display
#        ./api_tickets_listing.sh '{"per_page":10}' #where 10 is the number of tickets to display per page
#        ./api_tickets_listing.sh '{"state":"unread"}' #where unread is the state to filter by
#        ./api_tickets_listing.sh '{"folder":"12345"}' #where 12345 is the folder to filter by
#        ./api_tickets_listing.sh '{"assignee":"john.doe@company.com","state":"pending"}'

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
