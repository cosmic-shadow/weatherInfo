#! /bin/bash

# Enable debugging
set -x

## This script access an online weather report from wttr.in and extracts the observed and forecasted temperature at noon local time
# Defines the city variable for the weather report
city=Casablanca

# Extracts from the weather report the observed temperature and the forecasted temperature at noon local time
obs_temp=$(curl -s wttr.in/$city | sed "s/\x1B\[[0-9;]*[a-zA-Z]//g" | grep -oE -m 1 '\b[0-9]+\s°C\b')
fc_temp=$(curl -s wttr.in/$city | sed "s/\x1B\[[0-9;]*[a-zA-Z]//g" | grep -m 2 -oE '\b[0-9]+\s°C\b' | awk 'NR==3 {print}')
year=$(date | grep -oE '\d{4}')
month=$(date | grep -oE '[A-Za-z]{3}' | awk 'NR==2 {print}')
day=$(date | grep -oE '\b\d+\b' | awk 'NR==1 {print}')
hour=$(TZ="Africa/Casablanca" date | grep -oE '(\d\d:\d\d).*(\+\d\d)')

# It prints the reports
echo -e "\n### In the city of $city on $month $day of $year at $hour the observed temperature is $obs_temp and the forecasted temperature for tomorrow at noon is $fc_temp ###"
echo $year
echo $month
echo $day
echo $hour
echo $obs_temp
echo $fc_temp

# Disable debugging
set +x
#Send values and append them to log
record=$(echo -e "$year\t$month\t$day\t$hour\t$obs_temp\t$fc_temp")
echo $record >> rx_poc_hourly.log
echo "End"
