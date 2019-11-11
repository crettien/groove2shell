#!/bin/bash
# PUT https://api.groovehq.com/v1/tickets/:ticket_number/state
# curl -X PUT -d arg=val -d arg2=val2 localhost:8080

ticket_number=$1
# build the query
if [ -z $ticket_number ]; then
  echo "missing ticket number !"
  exit 2
fi

# initilization
source groove_api_key.conf

curl \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $access_token" \
-X PUT \
-d '{"state":"closed"}' \
"https://api.groovehq.com/v1/tickets/$ticket_number/state"
