# System Health Monitor (Linux Bash + Cron)

A Linux automation script that logs uptime, memory, disk usage, and top CPU processes hourly.
Built to demonstrate Linux automation, logging, and reliability practices.

## Features
- Timestamps and daily log files (`logs/system_health_<date>.log`)
- CPU, memory, and disk snapshots
- Runs automatically via `cron`
- Clean Bash implementation

## Run
```bash
chmod +x health_check.sh
./health_check.sh
