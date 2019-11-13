#!/bin/bash
# Author: Christophe Rettien
# Expected parameters: json output of customer listing
# Optional parameters: -
# Usage: ./customers_find_by_name.sh "John DOE" | ./customers_extract_id.sh

while read line; do
  echo ${line} | grep '"id":' | cut -d':' -f2 | tr -d ', '
done < /dev/stdin
