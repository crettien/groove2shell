#!/bin/bash

# initilization
source groove_api_key.conf

curl -s "https://api.groovehq.com/v1/mailboxes/?access_token=$access_token" | jq

