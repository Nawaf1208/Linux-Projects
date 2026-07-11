# User Provisioning Tool (Bash)

![Bash](https://img.shields.io/badge/bash-%234EAA25.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

![](Project-3.png)

A lightweight Linux administration utility that automates user account provisioning using Bash. The script creates new user accounts with a home directory, assigns a default shell and group, securely sets passwords, records provisioning activity in a log file, and provides a clean terminal dashboard.

## Provisioning Features
- **User Creation**: Creates new Linux user accounts with a dedicated home directory.
- **Default Shell Assignment**: Automatically assigns the configured login shell to each user.
- **Group Management**: Adds newly created users to the configured default group.
- **Secure Password Setup**: Accepts password input securely and configures it using `chpasswd`.
- **User Validation**: Prevents duplicate user creation by checking whether the username already exists.
- **Provisioning Logs**: Records successful and failed provisioning attempts with timestamps.

## Project Structure
- **User-Provision.sh**: Main Bash script responsible for user provisioning and logging.
- **users.log**: Stores the provisioning history.
- **README.md**: Project documentation and usage instructions.
- **.gitignore**: Prevents generated log files from being tracked by Git.

## Getting Started

### Prerequisites
- Linux Environment.
- Bash Shell.
- Root or sudo privileges.
- Standard Linux utilities:
  - `useradd`
  - `usermod`
  - `chpasswd`
  - `id`

### Installation
1. Navigate to your project directory:
   ```bash
   cd linux-projects/user-provisioning-tool
   ```

2. Make the script executable:
   ```bash
   chmod +x User-Provision.sh
   ```

## Usage
1. Run the script as root:
   ```bash
   sudo ./User-Provision.sh
   ```

2. Provide the requested information:
   - Username
   - Password
   - Full Name

3. The script will:
   - Create the user account.
   - Create the home directory.
   - Assign the default shell.
   - Add the user to the configured group.
   - Record the operation in the log file.

## Verification
1. **Verify the user exists:**
   ```bash
   id <username>
   ```

2. **Check the user's home directory:**
   ```bash
   ls -ld /home/<username>
   ```

3. **Review the provisioning log:**
   ```bash
   cat "$HOME/users.log"
   ```

4. **Verify group membership:**
   ```bash
   groups <username>
   ```

## Cleanup
To remove a test user created by the script:

```bash
sudo userdel -r <username>
```

To remove the log file:

```bash
rm -f "$HOME/users.log"
```
