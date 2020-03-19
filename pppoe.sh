#!/bin/bash
while :
do
wan_ip=$(ifconfig | grep "ppp")
stat=$(ping -q -c 1 -W 1 8.8.8.8  > /dev/null 2>&1 && echo "ok" || echo "FAIL")
date=$(date +%m-%d-%Y__%H:%M)
if [ -z "$wan_ip" ]; then
	echo "$date  :  No ppp interface"
	poff -a
	sleep 2
	pon dsl-provider
	sleep 3
	echo "---"
	sleep 60
else
	if [ "$stat" == "FAIL" ]; then
		echo "$date  :  Ping 8.8.8.8 is fail"
		poff -a
		sleep 2
		pon dsl-provider
		sleep 3
		echo "---"
		sleep 60
	else
		sleep 60
	fi
fi
done
