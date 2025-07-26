#!/usr/bin/env bash

source ~/.config/telegram_bot.conf
WARNING_LIMIT=5
LAST_ALERT_TIME=0
ALERT_CD=300

tg_alert_func() {
	local disk="$1"
	local use="$2"
	local message="WARNING! Section < $disk > is filled to $use%!"
		curl -s -X POST "https://api.telegram.org/bot$TG_TOKEN/sendMessage" \
                -d "chat_id=$TG_CHAT_ID" \
                -d "text=$message" >/dev/null 2>&1
}

check_disk_func() {
	local disk="$1"
	local use=$(df -h "$disk" | awk 'NR==2 {print $5}' | tr -d '%')
	if [ "$use" -ge "$WARNING_LIMIT" ]; then
		ALERT_TIME=$(date +%s)
		if (( ALERT_TIME - LAST_ALERT_TIME >= ALERT_CD )); then
			tg_alert_func "$disk" "$use"
			LAST_ALERT_TIME="$ALERT_TIME"
		fi
	fi
}

while true; do
        check_disk_func "/"
        check_disk_func "/home"
        sleep 10
done
