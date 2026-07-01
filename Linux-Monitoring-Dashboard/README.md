# Linux Monitoring Dashboard (Bash)

![Bash](https://img.shields.io/badge/bash-%234EAA25.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

A lightweight DevOps monitoring utility built with Bash to provide real-time visibility into Linux system health. The script monitors CPU, memory, and disk usage, displays a terminal dashboard, logs system statistics, and sends email alerts whenever configurable resource thresholds are exceeded.

## Features
- **Real-Time Dashboard**: Displays CPU, RAM, Disk usage, system uptime, and load average in a clean terminal dashboard.
- **Resource Monitoring**: Tracks CPU, memory, and root partition disk utilization against configurable thresholds.
- **Email Alerts**: Automatically sends email notifications when resource usage exceeds defined limits.
- **System Logging**: Records every execution and resource statistics in `Monitor.log` for auditing and troubleshooting.
- **Process Monitoring**: Displays the top 5 CPU-consuming and memory-consuming processes.
- **Automatic Log Rotation**: Prevents unlimited log growth by rotating the monitoring log after 1000 entries.
- **Built-in Safety Checks**: Verifies the availability of the `mail` utility before attempting to send notifications.

## Project Structure
- **Monitor.sh**: Main Bash script responsible for system monitoring, logging, dashboard generation, and email alerts.
- **monitor.log**: Stores historical monitoring data and alert events.
- **README.md**: Project documentation and usage instructions.
- **.gitignore**: Prevents generated logs and temporary files from being committed.

## Getting Started

### Prerequisites
- Linux Environment.
- Bash Shell.
- Standard Linux utilities:
  - `top`
  - `free`
  - `df`
  - `ps`
  - `awk`
  - `mail` (optional, required only for email alerts)

### Installation
1. Navigate to your project directory:
   ```bash
   cd linux-bash-git/linux-monitoring-dashboard
   ```

2. Make the script executable:
   ```bash
   chmod +x Monitor.sh
   ```

## Usage
1. Update the email address inside the script:
   ```bash
   EMAIL="your-email@example.com"
   ```

2. Run the monitoring dashboard:
   ```bash
   ./Monitor.sh
   ```

3. (Optional) Schedule automatic execution using Cron:
   ```bash
   crontab -e
   ```

   Example to run every 5 minutes:
   ```cron
   */5 * * * * /path/to/Linux-Monitoring-Dashboard/Monitor.sh
   ```

## Verification
1. **View the Dashboard**: Execute the script to see the live system monitoring dashboard.

2. **Review Monitoring Logs**:
   ```bash
   cat ~/monitor.log
   ```

3. **Test Email Alerts**:
   Temporarily reduce the threshold values (for example, set them to `1`) and run the script to verify that an alert email is generated.

## Cleanup
To remove the project, simply delete the project directory and the monitoring log:

```bash
rm -rf Linux-Monitoring-Dashboard
rm -f ~/monitor.log
```