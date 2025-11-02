Overview
This project is a simple Linux system monitoring utility written in Bash.
It collects key performance metrics such as uptime, memory usage, disk usage, and top CPU processes, then logs them into timestamped files for easy review.
A cron job can be configured to run this script automatically on a schedule.

Features
- Captures system uptime, memory, and disk usage
- Lists top CPU-consuming processes
- Saves each report with a timestamp to a logs directory
- Compatible with macOS and Linux systems
- Optional cron scheduling for continuous monitoring

Usage
Run manually:
./health_check.sh

To schedule automatically with cron:
crontab -e
*/5 * * * * /path/to/health_check.sh

Each run creates a log file in ./logs/ with the current date/time.