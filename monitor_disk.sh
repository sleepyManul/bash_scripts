#!/usr/bin/env bash

source ~/.config/telegram_bot.conf
WARNING_LIMIT=5

check_disk_func() {
	local disk=$1
	local use=$(df -h "$disk" | awk 'NR==2 {print $5}' | tr -d '%')
	if [ "$use" -ge "$WARNING_LIMIT" ]; then
		curl -s -X POST "https://api.telegram.org/bot$TG_TOKEN/sendMessage" \
		-d "chat_id=$TG_CHAT_ID" \
		-d "text=WARNING! $disk filled to $use%!" >/dev/null 2>&1
	fi
}

while true; do
        check_disk_func "/"
        check_disk_func "/home"
        sleep 10
done
