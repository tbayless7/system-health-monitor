#!/bin/bash
# System Health Monitor Script
# Author: Tyler Bayless

LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/system_health_$(date +%F).log"

mkdir -p $LOG_DIR

{
    echo "===== System Health Report ====="
    echo "Date: $(date)"
    echo "Hostname: $(hostname)"
    echo
    echo "--- Uptime ---"
    uptime
    echo
    echo "--- Memory Usage ---"
    free -h
    echo
    echo "--- Disk Usage ---"
    df -h
    echo
    echo "--- Top 5 Processes by CPU ---"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -6
    echo
    echo "==============================="
    echo
} >> $LOG_FILE

echo "System health logged to $LOG_FILE"
