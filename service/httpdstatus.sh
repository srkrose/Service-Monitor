#!/bin/bash

source /home/sample/scripts/dataset.sh

function cron_job() {
	sh $scripts/service/lsphpstatus.sh
}

function sleep_task() {
	cron_job

	if [ -r $svrlogs/service/lsphpissue_$logtime.txt ] && [ -s $svrlogs/service/lsphpissue_$logtime.txt ]; then
		while true; do
			today=$(date +"%F")
			now=$(date +"%H:%M")

			ldate=$(cat $svrlogs/service/lsphpissue_$logtime.txt | tail -1 | awk '{print $1}')
			ltime=$(cat $svrlogs/service/lsphpissue_$logtime.txt | tail -1 | awk '{print $2}' | awk -F':' '{print $1":"$2}')

			if [[ $ldate == "$today" && $ltime == "$now" ]]; then
				sleep 60

				cron_job
			else
				break
			fi
		done
	fi
}

sleep_task
