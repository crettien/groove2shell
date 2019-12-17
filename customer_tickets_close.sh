#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: customer_id <string>
# Optional parameters: -
# Usage: ./customer_tickets_close.sh 1234567

function help() {
  printf "\033[33m# HELP: customer_tickets_close\n\033[0m"
  printf "\033[33m# Expected parameters:\tcustomer id <string>\n\033[0m"
  printf "\033[33m# Optional parameters:\t-\n\033[0m"
  printf "\033[33m# Usage:\t\t./customer_tickets_close.sh 1234567 #where 1234567 is a customer id\n\033[0m"
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  help
  exit 0
fi

customer_id=$1

# build the query
if [ -z $customer_id ]; then
  echo "missing customer id !"
  exit 2
fi

current_page=`./api_tickets_listing.sh "{\"page\":1,\"customer\":$customer_id,\"state\":\"unread\"}" | grep current_page | cut -d':' -f2 | tr -d ', '`
total_pages=`./api_tickets_listing.sh "{\"page\":1,\"customer\":$customer_id,\"state\":\"unread\"}" | grep total_pages | cut -d':' -f2 | tr -d ', '`

printf "\033[34m* Tickets to close range from page $current_page to $total_pages\n\033[0m\n"

for (( page=current_page; page<=$total_pages; page++ ))
do
  printf "\033[34m\tPage $page\n\033[0m\n"

  tickets=`./api_tickets_listing.sh '{"page":1,"customer":2013998100,"state":"unread"}' | grep number | cut -d':' -f2 | tr -d ' ,'`

  for ticket in $tickets
  do
    printf "\033[32m\t\tclosing ticket #$ticket\n\033[0m"
    ./api_ticket_update_state.sh $ticket closed
  done
  printf "\033[33m\tPause 5 seconds...\n\033[0m\n"
  sleep 5
done

printf "\033[34m* Closed all tickets on $total_pages pages.\n\033[0m\n"
