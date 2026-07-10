# Log Rotation Automation (Bash)

![Bash](https://img.shields.io/badge/bash-%234EAA25.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

A lightweight Linux automation utility that simplifies log lifecycle management using Bash. The script automatically compresses old log files, removes outdated compressed archives based on configurable retention periods, records every operation in a log file, and provides a clean terminal dashboard.

## Automation Features
- **Automatic Log Compression**: Compresses `.log` files older than the configured number of days using `gzip`.
- **Archive Cleanup**: Deletes compressed `.log.gz` files older than the configured retention period.
- **Configurable Retention**: Easily customize compression and deletion intervals.
- **Recursive Directory Scanning**: Searches the target directory for eligible log files.
- **Activity Logging**: Records every compression and deletion operation with timestamps.
- **Terminal Dashboard**: Displays the current configuration and execution progress.

## Project Structure
- **Log-Rotation.sh**: Main Bash script responsible for log compression and archive cleanup.
- **rotation.log**: Stores the history of compression and deletion activities.
- **README.md**: Project documentation and usage instructions.
- **.gitignore**: Prevents generated log files from being tracked by Git.

## Getting Started

### Prerequisites
- Linux Environment.
- Bash Shell.
- Standard Linux utilities:
  - `find`
  - `gzip`
  - `rm`

### Installation
1. Navigate to your project directory:
   ```bash
   cd linux-projects/log-rotation-automation
   ```

2. Make the script executable:
   ```bash
   chmod +x Log-Rotation.sh
   ```

## Usage
1. Run the script:
   ```bash
   ./Log-Rotation.sh
   ```

2. The script will:
   - Scan the target directory for old log files.
   - Compress `.log` files older than the configured compression period.
   - Delete compressed `.log.gz` files older than the configured retention period.
   - Record all operations in `rotation.log`.

## Verification
1. **Verify compressed log files:**
   ```bash
   find /var/log -name "*.log.gz"
   ```

2. **Review the activity log:**
   ```bash
   cat "$HOME/rotation.log"
   ```

3. **Verify old archives were removed:**
   ```bash
   find /var/log -name "*.log.gz" -mtime +30
   ```

## Cleanup
To remove the generated activity log:

```bash
rm -f "$HOME/rotation.log"
```