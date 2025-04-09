#!/bin/bash

LOG_DIR=~/project/logs
BACKUP_DIR=$LOG_DIR/backup
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
FILENAME="app.log"
ROTATED_FILE="app-$TIMESTAMP.log.gz"
MAX_BACKUPS=10

mkdir -p $BACKUP_DIR

if [ -f "$LOG_DIR/$FILENAME" ]; then
  echo "[+] Rotating log file..."
  gzip -c  "$LOG_DIR/$FILENAME" > "$BACKUP_DIR/$ROTATED_FILE"
  echo "" > "$LOG_DIR/$FILENAME"
  echo "[+] Log rotated and compressed to $ROTATED_FILE"
else
  echo "[!] Log file $FILENAME not found in $LOG_DIR"
fi

echo "[+] Cleaning old backups..."
cd $BACKUP_DIR
ls -tp | grep -v '/$' | tail -n +$(($MAX_BACKUPS + 1)) | xargs -I {} rm -- {}
echo "[+] Done."
	
	  	 
