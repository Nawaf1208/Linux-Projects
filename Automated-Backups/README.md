# Automated Backups (Bash)

![Bash](https://img.shields.io/badge/bash-%234EAA25.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

A lightweight DevOps automation utility that creates compressed backups of Linux directories using Bash. The script generates timestamped backup archives, maintains detailed backup logs, automatically removes outdated backups based on a configurable retention period, and provides a clean terminal dashboard.

## Backup Features
- **Compressed Backups**: Creates timestamped `.tar.gz` archives to prevent overwriting previous backups.
- **Automatic Directory Creation**: Creates the backup directory and log file if they do not already exist.
- **Backup Logging**: Records successful and failed backup operations with timestamps and destination details.
- **Retention Management**: Automatically deletes backup archives older than the configured retention period.
- **Backup Size Display**: Displays the size of the generated backup archive after completion.
- **Error Handling**: Validates the source directory before creating backups to prevent failures.

## Project Structure
- **Backup.sh**: Main Bash script responsible for backup creation, logging, cleanup, and terminal output.
- **Backup.log**: Stores backup history and cleanup events.
- **README.md**: Project documentation and usage instructions.
- **.gitignore**: Prevents generated logs and backup archives from being tracked in version control.

## Getting Started

### Prerequisites
- Linux Environment.
- Bash Shell.
- Standard Linux utilities:
  - `tar`
  - `find`
  - `du`
  - `date`

### Installation
1. Navigate to your project directory:
   ```bash
   cd linux-projects/Automated-Backups
   ```

2. Make the script executable:
   ```bash
   chmod +x Backup.sh
   ```

## Usage
1. Update the source and backup directories inside the script if required:
   ```bash
   SOURCE_DIR="$HOME/Linux"
   BACKUP_DIR="$HOME/Backup"
   ```

2. Run the script:
   ```bash
   ./Backup.sh
   ```

3. (Optional) Schedule automatic backups using Cron:
   ```bash
   crontab -e
   ```

   Example (run every day at 2:00 AM):
   ```cron
   0 2 * * * /path/to/Automated-Backups/Backup.sh
   ```

## Verification
1. **Check Backup Archive**:
   ```bash
   ls -lh "$HOME/Backup"
   ```

2. **Review Backup Logs**:
   ```bash
   cat "$HOME/Backup.log"
   ```

3. **Extract and Verify Backup**:
   ```bash
   tar -tzf "$HOME/Backup/backup_<timestamp>.tar.gz"
   ```

## Cleanup
To remove the project and generated backup files:

```bash
rm -rf "$HOME/Backup"
rm -f "$HOME/Backup.log"
```
