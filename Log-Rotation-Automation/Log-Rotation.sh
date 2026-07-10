#!/bin/bash

# Configuration
TARGET_DIR="/var/log"
LOG_FILE="$HOME/rotation.log"
COMPRESSION_DAYS=7
DELETE_DAYS=30

# Directory check
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory '$TARGET_DIR' does not exist."
    exit 1
fi 

# Log file
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Compress old log files
compress_logs() {

    find "$TARGET_DIR" -type f -name "*.log" -mtime +"$COMPRESSION_DAYS" | while read -r file

    do
        if gzip "$file"; then
            echo "[$(date)] Compressed: $file.gz" >> "$LOG_FILE"
        fi
    done
}

# Delete old compressed files
delete_logs() {

    find "$TARGET_DIR" -type f -name "*.log.gz" -mtime +"$DELETE_DAYS" | while read -r file

    do
        if rm "$file"
            echo "[$(date)] Deleted: $file" >> "$LOG_FILE"
        fi
    done
}

# Dashboard

clear

echo "======================================"
echo "      Log Rotation Automation         "
echo "======================================"

echo
echo "Target Directory  :   $TARGET_DIR"
echo "Compress After    :   $COMPRESSION_DAYS Days"
echo "Delete After      :   $DELETE_DAYS Days"

echo
echo "Compressing logs..."
compress_logs
echo "Log compression completed."

echo 
echo "Deleting old archives..."
delete_logs
echo "Old archive cleanup completed."

echo
echo "======================================"
echo "              Completed               "
echo "======================================"