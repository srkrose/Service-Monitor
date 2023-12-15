#!/bin/bash

source /home/sample/scripts/dataset.sh

function kernal_update() {
	pckg=$(yum list kernel -q | grep "Available Packages")

	if [[ ! -z "$pckg" ]]; then
		echo "$(date +"%F %T") kernel updated" >>$svrlogs/logs/kupdate_$logtime.txt

		yum upgrade kernel -y
	fi
}

function svr_reboot() {
	rcheck=$(whmapi1 system_needs_reboot | grep "needs_reboot:" | awk '{print $NF}')

	if [ "$rcheck" -eq 1 ]; then
		echo "$(date +"%F %T") server reboot" >>$svrlogs/logs/reboot_$logtime.txt

		whmapi1 reboot
	fi
}

kernal_update

svr_reboot
