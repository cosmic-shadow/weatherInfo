#! /bin/bash

## Basic functionality of logging the date and a message everytime that a scheduled job is run
# Print date and time
message="--> Does this work?"
current_date=$(date)
echo "$current_date $message"