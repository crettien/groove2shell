#!/bin/bash

customer_id=$1

# build the query
if [ -z $customer_id ]; then
  echo "missing customer id !"
  exit 2
fi

current_page=`./listing_tickets.sh "{\"page\":1,\"customer\":$customer_id,\"state\":\"unread\"}" | grep current_page | cut -d':' -f2 | tr -d ', '`
total_pages=`./listing_tickets.sh "{\"page\":1,\"customer\":$customer_id,\"state\":\"unread\"}" | grep total_pages | cut -d':' -f2 | tr -d ', '`

printf "\033[34m* Tickets to close range from page $current_page to $total_pages\n\033[0m\n"

for (( page=current_page; page<=$total_pages; page++ ))
do
  printf "\033[34m\tPage $page\n\033[0m\n"

  tickets=`./listing_tickets.sh '{"page":1,"customer":2013998100,"state":"unread"}' | grep number | cut -d':' -f2 | tr -d ' ,'`

  for ticket in $tickets
  do
    printf "\033[32m\t\tclosing ticket #$ticket\n\033[0m"
    ./close_ticket.sh $ticket
  done
done

printf "\033[34m* Closed all tickets on $total_pages pages.\n\033[0m\n
