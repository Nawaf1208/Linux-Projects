#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=80

# Configuration
EMAIL="abc123@gmail.com"
LOG_FILE="$HOME/monitor.log"
HOSTNAME=$(hostname)

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
RESET="\e[0m"

# File check
touch "$LOG_FILE"

# Rotate log after 1000 lines
if [ -f "$LOG_FILE" ] && [ "$(wc -l < "$LOG_FILE")" -gt 1000 ]; then
    mv "$LOG_FILE" "$LOG_FILE.old"
    touch "$LOG_FILE"
fi

# Mail check
MAIL_AVAILABLE=true
if ! command -v mail &> /dev/null; then
    MAIL_AVAILABLE=false
fi

# Functions
get_cpu(){
    top -bn1 | awk '/Cpu/ {print int(100-$8)}'
}

get_ram(){
    free | awk '/Mem:/ {print int(($3/$2)*100)}'
}

get_disk(){
    df / | awk 'NR==2 {gsub("%",""); print int($5)}'
}

log_status(){
    echo "$(date): [$HOSTNAME] CPU:${CPU_USAGE}% RAM:${RAM_USAGE}% DISK:${DISK_USAGE}%" >> "$LOG_FILE"
}

send_alert(){

    if [ "$MAIL_AVAILABLE" = true ]; then

        echo -e "High resource usage detected.\n

Hostname : $HOSTNAME

CPU  : ${CPU_USAGE}% 
RAM  : ${RAM_USAGE}% 
DISK : ${DISK_USAGE}%

Time : $(date) " | mail -s "Resource Alert - $HOSTNAME" "$EMAIL"

        echo "$(date): Alert send" >> "$LOG_FILE"

    else

        echo "$(date): Mail command not found. Email not send" >> "$LOG_FILE"
    fi
}

# System Information
CPU_USAGE=$(get_cpu)
RAM_USAGE=$(get_ram)
DISK_USAGE=$(get_disk)

UPTIME=$(uptime -p)
LOAD=$(uptime | awk -F'load average:' '{print $2}')

log_status

# Dashboard

clear

echo -e "${BLUE}"
echo "==============================================="
echo "          Linux Monitoring Dashboard           "
echo "==============================================="
echo -e "${RESET}"

echo "Hostname      : $HOSTNAME"
echo "Date          : $(date)"
echo "Uptime        : $UPTIME"
echo "Load Average  : $LOAD"

echo

echo -e "CPU Usage  : ${YELLOW}${CPU_USAGE}%${RESET}"
echo -e "RAM Usage  : ${YELLOW}${RAM_USAGE}%${RESET}"
echo -e "Disk Usage : ${YELLOW}${DISK_USAGE}%${RESET}"

echo

# Status

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ] || \
   [ "$RAM_USAGE" -gt "$RAM_THRESHOLD" ] || \
   [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then

   echo -e "${RED}Status : WARNING - High Resource Usage${RESET}"

else
   echo -e "${GREEN}Status : HEALTHY${RESET}"
   echo "$(date): System resources are within limits." >> "$LOG_FILE"
fi

echo
echo "==============================================="
echo "             Top 5 CPU Processes               "
echo "==============================================="

ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo
echo "==============================================="
echo "             Top 5 Memory Processes            "
echo "==============================================="

ps -eo pid,comm,%mem --sort=-%mem | head -n 6

echo
echo "==============================================="
echo "                 Disk Usage                    "
echo "==============================================="

df -h

echo
echo "==============================================="
echo "                 Completed                     "
echo "==============================================="
