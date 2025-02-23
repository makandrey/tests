#!/bin/bash

# get service uptime
uptime=$(ps -eo comm,lstart | grep test | awk '{printf("%s %s %s %s\n", $3,$4,$6,$5 )}')

if [[ -z $uptime ]]; then
    echo "Service not running" && exit 1
fi

# convert service uptime to epochtime format
uptime_sec=$(date +'%s' -d "$uptime")

# get system time in epochtime format
curtime_sec=$(date +%s)

# check last time restarting
# if process will restarting in last 60 sec
if [ $(expr $curtime_sec - $uptime_sec) -lt 60 ]; then
    echo "$uptime    service monitor has been restarted" >> /var/log/monitoring.log
# if process running
else
    # check service available
    service_avail=$(curl -Is https://test.com/monitoring/test/api -m 3 | head -n 1)
    if [[ "$service_avail" != *"200"* ]]; then
        echo "$(date +"%b %d %Y %T")    service not available" >> /var/log/monitoring.log
    fi
fi
