#!/bin/bash

source /home/sample/scripts/dataset.sh

function process_check() {
	process=$(ps aux | grep "/home/$cpuser/scripts/service/httpdstatus.sh" | grep -v grep)

	if [[ -z $process ]]; then
		sh $scripts/service/httpdstatus.sh
	else
		echo "$(date +"%F %T")" >>$svrlogs/service/process_$logtime.txt
		echo "$process" >>$svrlogs/service/process_$logtime.txt
	fi
}

process_check
