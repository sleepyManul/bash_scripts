#!/usr/bin/env bash

set -e

SOURCE_DIR="/home/manul/Programs"
BACKUP_DIR="/home/manul/backup"
BACKUP_NAME="backup_$(date +%Y-%m-%d_%H-%M).tar.gz"


echo "Backup $SOURCE_DIR is starting!"

if [ ! -d "$BACKUP_DIR" ]; then
	mkdir -pv "$BACKUP_DIR"
fi

tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$SOURCE_DIR" .

if [ -e "$BACKUP_DIR/$BACKUP_NAME" ]; then
	echo "Backup $SOURCE_DIR is ready! Delete backup elder 14 days"
	find "$BACKUP_DIR" -type f -name "backup*" -mtime +14 -exec rm -fv {} \;
else
	echo "Backup $SOURCE_DIR is NOT ready!"
fi
