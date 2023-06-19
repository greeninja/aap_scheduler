#!/bin/bash

# Every 5 minuts for 2 hours

minutes_in_front=5

for i in {1..24}; do
  ## Server Name
  server=server-nctesting.testing.lab
  days_in_front=7

  scheduled_update_time=$(TZ=UTC date '+%Y-%m-%d %H:%M:00' -d "+$days_in_front days +$minutes_in_front minutes")

  echo $scheduled_update_time

  minutes_in_front=$(( minutes_in_front + 5 ))
  
  mysql -h 192.168.122.12 -u root -pd0ddl3 -e "insert into patching.patch (server, status, update_time) values (\"$server\", \"Booked\", \"$scheduled_update_time\");"

done
