#!/bin/bash

LOCK=/var/tmp/lockfile

if [-f $LOCK]
then
        echo "File is busy"
        exit 1
else
        touch $LOCK
        trap 'rm -f $LOCK; exit $?' INT TERM EXIT

        from_time=$(cat /var/log/cron | grep test | sort | tail -1 | awk '{print $3}')
        to_data=$(date '+%H:%M:%S')

        echo "Logging server requests from $from_time to $to_data "

        x=20
        y=20

        awk '{print $1}' access_log | uniq -c | sort -n | tail -$x | mail -s "Top $x IP addresses" email@test.ru
        awk '{print $7}' access_log | uniq -c | sort -n | tail -$y | mail -s "Top $y URL-addresses" email@test.ru
        awk '($9 ~ 404)' access_log | mail -s "404 Errors" email@test.ru
        awk '{print $9}' access_log | sort | uniq -c | mail -s "Queries statistics" email@test.ru

        rm -f $LOCK
        trap - INT TERM EXIT
fi
