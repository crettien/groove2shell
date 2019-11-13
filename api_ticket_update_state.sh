#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: ticket number <integer>
#                      state <string> ("unread","opened","pending","closed","spam")
# Optional parameters: -
# Usage: ./api_ticket_update_state.sh 1234 "closed" #where 1234 is a ticket number and
#                                           closed a state to update to

ticket_number=$1
# build the query
if [ -z $ticket_number ]; then
  echo "missing ticket number !"
  exit 2
fi
state=$2
# build the query
if [ -z $state ]; then
  echo "missing ticket state !"
  exit 2
fi
# initilization
source groove_api_key.conf

curl \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $access_token" \
-X PUT \
-d '{"state":"'$state'"}' \
"https://api.groovehq.com/v1/tickets/$ticket_number/state"
