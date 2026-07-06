#!/bin/bash

# Configuration
SOURCE_DIR="$HOME/Linux"
BACKUP_DIR="$HOME/Backup"
LOG_FILE="$HOME/Backup.log"
RETENTION_DAYS=30

# Source directory
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# Backup directory
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Log file
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"

# Backup
backup(){
    if tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$SOURCE_DIR" .;then
        echo "[$(date)]" >> "$LOG_FILE"
        echo "Backup Successful" >> "$LOG_FILE"
        echo "Source     : $SOURCE_DIR" >> "$LOG_FILE"
        echo "Backup File: $BACKUP_FILE" >> "$LOG_FILE"
        echo "Destination: $BACKUP_DIR" >> "$LOG_FILE" 
        return 0
    else
        echo "[$(date)]" >> "$LOG_FILE"
        echo "Backup failed" >> "$LOG_FILE"
        echo "Source     : $SOURCE_DIR" >> "$LOG_FILE"
        echo "Backup File: $BACKUP_FILE" >> "$LOG_FILE"
        echo "Destination: $BACKUP_DIR" >> "$LOG_FILE" 
        return 1
    fi
}

# Delete old backups
old_backup(){
    find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS -delete

    echo "[$(date)] Old backups older than $RETENTION_DAYS days deleted." >> "$LOG_FILE"
}

clear

# Dashboard
echo "======================================"
echo "          Automated Backup            "
echo "======================================"

echo
echo "Source      : $SOURCE_DIR"
echo "Backup      : $BACKUP_DIR"
echo "Backup File : $BACKUP_FILE"

echo
echo "Creating backup..."
echo

if backup; then 
    echo "Backup created succesfully!"
    echo "Backup Size : $(du -sh "$BACKUP_DIR/$BACKUP_FILE" | cut -f1)"
else
    echo "Backup creation failed."
    exit 1
fi

echo
echo "Deleting old backups..."
old_backup
echo "Old backups deleted"

echo
echo "======================================"
echo "              Completed               "
echo "======================================"