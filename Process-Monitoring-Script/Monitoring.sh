#!/bin/bash

# Configuration
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
LOG_FILE="$HOME/monitoring.log"
HOSTNAME=$(hostname)

# Log file 
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi 

high_cpu() {

    ps -eo pid,comm,%cpu --sort=-%cpu | \
    awk -v threshold="$CPU_THRESHOLD" '$3 > threshold' | \
    while read -r pid process cpu
    do
        echo "[$(date)] High CPU: PID=$pid Process=$process CPU=${cpu}%" >> "$LOG_FILE"
        echo >> "$LOG_FILE"
    done
}

high_memory() {

    ps -eo pid,comm,%mem --sort=-%mem | \
    awk -v threshold="$MEMORY_THRESHOLD" '$3 > threshold' | \
    while read -r pid process mem
    do
        echo "[$(date)] High Memory: PID=$pid Process=$process MEMORY=${mem}%" >> "$LOG_FILE"
        echo >> "$LOG_FILE"
    done
}

# Dashboard

clear

echo "======================================"
echo "       Process Monitoring Tool        "
echo "======================================"

echo
echo "Hostname          : $HOSTNAME"
echo "Date              : $(date)"

echo
echo "CPU Threshold     : $CPU_THRESHOLD%"
echo "Memory Threshold  : $MEMORY_THRESHOLD%"
echo "Log File          : $LOG_FILE"

echo
echo "Checking CPU usage..."
high_cpu
echo "CPU monitoring completed. Results saved to $LOG_FILE."

echo
echo "Checking memory usage..."
high_memory
echo "Memory monitoring completed. Results saved to $LOG_FILE."

echo
echo "======================================"
echo "              Completed               "
echo "======================================"