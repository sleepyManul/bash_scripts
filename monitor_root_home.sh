#!/usr/bin/env bash

set -e

WARNING_LIMIT=90

check_disk_func() {
	local disk=$1
	local use=$(df -h "$disk" | awk 'NR==2 {print $5}' | tr -d '%')
	if [ "$use" -ge "$WARNING_LIMIT" ]; then
		echo "WARNING! $disk filled to $use%!"
	fi
}

check_disk_func "/"
check_disk_func "/home"
