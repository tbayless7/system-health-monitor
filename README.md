System Health Monitor
Overview

The System Health Monitor is a Bash utility that collects and logs system metrics: uptime, memory usage, disk utilization, and the top CPU-consuming processes. Results are written to timestamped log files in the logs/ directory. The script can be run manually or scheduled with cron.

Features

Works on Linux and macOS (auto-detects available commands)

Timestamped log files

CPU, memory, and disk summaries

Ready for automation via cron

Project Structure
system-health-monitor/
├── health_check.sh
├── setup-cron.md
├── README.md
├── .gitignore
└── logs/

Usage
Run manually
chmod +x health_check.sh
./health_check.sh


Logs are written to:

./logs/system_health_YYYY-MM-DD.log

Automate with cron

See setup-cron.md for full details. Example hourly entry (adjust the path):

0 * * * * /Users/tylerbayless/Projects/system-health-monitor/health_check.sh >> /Users/tylerbayless/Projects/system-health-monitor/cron_output.log 2>&1

Example Output
===== System Health Report =====
Date: Sat Nov 1 13:00:01 2025
Hostname: Tylers-MacBook-Pro

--- Uptime ---
13:00  up 5 days,  2 users, load averages: 2.15 2.09 1.95

--- Memory Usage ---
Total: 16384MB | Used: 8120MB | Free: 8264MB

--- Disk Usage ---
Filesystem            Size  Used Avail Use% Mounted on
/Users/tylerbayless   931G  721G  210G  78%

--- Top 5 Processes by CPU ---
root        123   45.0  ...
tyler       245   10.5  ...
...

===============================

Requirements

Bash 4+

Linux (Ubuntu/Debian) or macOS

cron for scheduled runs