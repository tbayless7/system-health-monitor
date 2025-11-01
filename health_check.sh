#!/bin/bash
# System Health Monitor Script
# Author: Tyler Bayless

set -euo pipefail

LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/system_health_$(date +%F).log"
mkdir -p "$LOG_DIR"

is_cmd() { command -v "$1" >/dev/null 2>&1; }

# ---- Sections ----

print_header() {
  echo "===== System Health Report ====="
  echo "Date: $(date)"
  echo "Hostname: $(hostname)"
  echo
}

print_uptime() {
  echo "--- Uptime ---"
  if is_cmd uptime; then
    uptime
  else
    echo "(uptime not available)"
  fi
  echo
}

print_memory() {
  echo "--- Memory Usage ---"
  if is_cmd free; then
    # Linux
    free -h
  else
    # macOS fallback using vm_stat
    if is_cmd vm_stat; then
      pagesize=$(vm_stat | awk '/page size of/ {print $8}')
      free_pages=$(vm_stat | awk '/Pages free/ {gsub("\\.",""); print $3}')
      speculative=$(vm_stat | awk '/Pages speculative/ {gsub("\\.",""); print $3}')
      wired=$(vm_stat | awk '/Pages wired down/ {gsub("\\.",""); print $4}')
      active=$(vm_stat | awk '/Pages active/ {gsub("\\.",""); print $3}')
      inactive=$(vm_stat | awk '/Pages inactive/ {gsub("\\.",""); print $3}')
      purgeable=$(vm_stat | awk '/Pages purgeable/ {gsub("\\.",""); print $3}')
      free_mb=$(( (free_pages + speculative) * pagesize / 1024 / 1024 ))
      used_mb=$(( (wired + active + inactive + purgeable) * pagesize / 1024 / 1024 ))
      total_mb=$(( free_mb + used_mb ))
      echo "Total: ${total_mb}MB | Used: ${used_mb}MB | Free: ${free_mb}MB"
    else
      echo "(memory info not available)"
    fi
  fi
  echo
}

print_disk() {
  echo "--- Disk Usage ---"
  df -h
  echo
}

print_top_cpu() {
  echo "--- Top 5 Processes by CPU ---"
  if is_cmd ps; then
    # Prefer Linux extended format if supported
    if ps -eo pid,comm,%cpu >/dev/null 2>&1; then
      ps -eo pid,comm,%cpu --sort=-%cpu | head -6
    else
      # macOS format
      ps aux | sort -nrk 3 | head -5
    fi
  else
    echo "(ps not available)"
  fi
  echo
}

{
  print_header
  print_uptime
  print_memory
  print_disk
  print_top_cpu
  echo "==============================="
  echo
} >> "$LOG_FILE"

echo "System health logged to $LOG_FILE"
