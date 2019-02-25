for pid in $(ls /proc/ | grep "[0-9]\+" | sort -g)
do
state=$(grep -E -h -s -i "state:\s(.+)" "/proc/"$pid"/status" | sed 's|State:||')
ppid=$(grep -E -h -s -i "ppid:\s(.+)" "/proc/"$pid"/status" | grep -o "[0-9]\+")
sleepavg=$(grep -E -h -s -i "avg_atom(.+)" "/proc/"$pid"/sched" | grep -o "[0-9.]\+")
execcmd=$(tr '\0' ' ' < "/proc/"$pid"/cmdline")
if [[ -z $sleepavg ]]
then sleepavg=0
fi
if [[ $ppid != "" ]]
then status=$status"$pid        $ppid   $state  $sleepavg       $execcmd"$'\n'
fi
done
echo "PID | PPID | STAT | TIME | COMMAND"
echo "$status" | sort -t " " -n
