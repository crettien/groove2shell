#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: ticket number <integer>
#                      state <string> ("unread","opened","pending","closed","spam")
# Optional parameters: -
# Usage: ./api_ticket_update_state.sh 1234 "closed" #where 1234 is a ticket number and
#                                           closed a state to update to

function help() {
  printf "\033[33m# HELP: api_ticket_update_state\n\033[0m"
  printf "\033[33m# Expected parameters:\tticket number <integer>\n\033[0m"
  printf "\033[33m#\t\t\tstate <string> (\"unread\",\"opened\",\"pending\",\"closed\",\"spam\")\n\033[0m"
  printf "\033[33m# Optional parameters:\t-\n\033[0m"
  printf "\033[33m# Expected parameters:\tticket number <integer>\n\033[0m"
  printf "\033[33m# Usage:\t\t./api_ticket_update_state.sh 1234 \"closed\" #where 1234 is a ticket number and\n\033[0m"
  printf "\033[33m#\t\t\tclosed a state to update to\n\033[0m\n"
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  help
  exit 0
fi

ticket_number=$1
# build the query
if [ -z $ticket_number ]; then
  printf "\033[31m\tMissing ticket number !\n\033[0m\n"
  help
  exit 2
fi
state=$2
# build the query
if [ -z $state ]; then
  printf "\033[31m\tMissing ticket state !\n\033[0m\n"
  help
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
