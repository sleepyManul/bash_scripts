#!/usr/bin/env bash

set -e

LOG_DIR="/var/log"

echo "Starting log cleaner in $LOG_DIR"

if [ ! -d "$LOG_DIR" ]; then
	echo "$LOG_DIR does not exist" >&2
	exit 1
fi

if [ ! -w "$LOG_DIR" ]; then
	echo "Not permission in $LOG_DIR. Try sudo." >&2
	exit 1
fi

find "$LOG_DIR" -name "*.log" -type f -mtime +7 -exec rm -f {} \;

echo "Logs older than 7 days in $LOG_DIR is cleaning!"
