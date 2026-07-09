#!/bin/bash

# Configuration
DEFAULT_SHELL="/bin/bash"
DEFAULT_GROUP="sudo"
LOG_FILE="$HOME/users.log"

# Root check
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Inputs
echo "Enter Username:"
read USERNAME

echo "Enter Password:"
read -s PASSWORD

echo 

echo "Enter Full Name:"
read FULLNAME

# Validation
if [ -z "$USERNAME" ]; then
    echo "Username must not be empty."
    exit 1
fi

# Log file
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Create user
create_user() {

    if id "$USERNAME" &> /dev/null; then
    
        echo "User '$USERNAME' already exists."
    
        echo "[$(date)]" >> "$LOG_FILE"
        echo "Username  :   $USERNAME" >> "$LOG_FILE"
        echo "Status    :   Failed (User already exists)" >> "$LOG_FILE"

        return 1

    fi

    if useradd -m -s "$DEFAULT_SHELL" -c "$FULLNAME" "$USERNAME"; then

        if echo "$USERNAME:$PASSWORD" | chpasswd; then

            if usermod -aG "$DEFAULT_GROUP" "$USERNAME"; then

                echo "[$(date)]" >> "$LOG_FILE"
                echo "Username  :   $USERNAME" >> "$LOG_FILE"
                echo "Group     :   $DEFAULT_GROUP" >> "$LOG_FILE"                
                echo "Shell     :   $DEFAULT_SHELL" >> "$LOG_FILE"
                echo "Status    :   Success" >> "$LOG_FILE"


                return 0

            else

                echo "Failed to add user to group." >> "$LOG_FILE"
                return 1

            fi

        else

            echo "Failed to set password." >> "$LOG_FILE"
            return 1
        fi

    else

        echo "[$(date)]" >> "$LOG_FILE"
        echo "Username  :   $USERNAME" >> "$LOG_FILE"
        echo "Status    :   Failed" >> "$LOG_FILE"

        return 1

    fi
}

# Dashboard

clear

echo "======================================"
echo "       User Provisioning Tool         "
echo "======================================"

echo
echo "Username : $USERNAME"
echo "Group    : $DEFAULT_GROUP"
echo "Shell    : $DEFAULT_SHELL"

echo
echo "Creating user..."
echo

if create_user; then
    echo "User created successfully."
else
    echo "User creation failed."
fi

echo
echo "======================================"
echo "              Completed               "
echo "======================================"
