#!/bin/bash

for i in {1..5}; do
  ## Server Name
  server=server$(( ( RANDOM % 50 )  + 1 )).testing.lab

  ## Random Date time
  #days_in_front=$(shuf -i 7-11 -n 1)
  days_in_front=7
  hours_in_front=$(shuf -i 0-24 -n 1)
  minutes_array=("00" "15" "30" "45")
  minute=$(shuf -e "${minutes_array[@]}" -n 1)
  #echo "Minutes = $minute"

  scheduled_update_time=$(date '+%Y-%m-%d %H' -d "+$days_in_front days +$hours_in_front hours")

  echo "$server $scheduled_update_time:$minute:00"

#  curl -X POST http://192.168.122.12:8080/patch/ --header "Content-Type: application/json" --data "{\"server\": \"$server\", \"PatchStart\": \"$scheduled_update_time:$minute:00\", \"Status\": \"Booked\"}"
  mysql -h 192.168.122.12 -u root -pd0ddl3 -e "insert into patching.patch (\"server\", \"status\", \"update_time\")" values (\"$server\", \"Booked\", \"$scheduled_update_time\");"
done
