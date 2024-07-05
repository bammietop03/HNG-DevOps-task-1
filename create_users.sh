#!/bin/bash

# create_users.sh
# This script reads a text file containing usernames and groups, creates users and groups,
# sets up home directories, generates random passwords, and logs actions.
# Usage: ./create_users.sh <text-file>


# Check if the script is run as root
if [[ "$EUID" -ne 0 ]]; then
    echo "This script must be run as root." >&2
    exit 1
fi

# Check if a file argument is provided
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <text-file>" >&2
    exit 1
fi


# Input file containing USERNAMEs and GROUPS (format: user;GROUPS)
CONTENT_FILE="$1"
PASSWORD_FILE="/var/secure/user_passwords.csv"
LOG_FILE="/var/log/user_management.log"

# Check if the file exists
if [[ ! -f "$CONTENT_FILE" ]]; then
    echo "File $CONTENT_FILE does not exist." >&2
    exit 1
fi


# Creating log file if it doesn't exist
touch "$LOG_FILE"
mkdir -p /var/secure
chown -R $(whoami) /var/secure

# Function to generate a random password
generate_password() {
     tr -dc 'A-Za-z0-9!@#$%^&*()' < /dev/urandom | head -c 8
}

# Running through the list of users in the txt file
while IFS=';' read -r USERNAME GROUPS; do
    # Creating user
    useradd -m -s /bin/bash "$USERNAME" &>> "$LOG_FILE"

    # Creating group with the same name as the USERNAME
    groupadd "$USERNAME" &>> "$LOG_FILE"

    # Adding user to personal group
    usermod -aG "$USERNAME" "$USERNAME" &>> "$LOG_FILE"

    # checking to see if user has additional GROUPS 
    IFS=',' read -ra group_array <<< "$GROUPS"
    for group in "${group_array[@]}"; do
        groupadd "$group" &>> "$LOG_FILE"
        usermod -aG "$group" "$USERNAME" &>> "$LOG_FILE"
    done

    # Generating and set password
    password=$(generate_password)
    echo "$USERNAME:$password" | chpasswd &>> "$LOG_FILE"

    # Log user creation details
    echo "User '$USERNAME' created with GROUPS: $GROUPS" >> "$LOG_FILE"

    # Append USERNAME and password to the secure password file
    echo "$USERNAME,$password" >> "$PASSWORD_FILE"
done < "$CONTENT_FILE"

# Set permissions for password file
chmod 600 "$PASSWORD_FILE"

echo "User creation completed." 
echo "Detailed logs stored in $LOG_FILE."
echo "Passwords is stored in $PASSWORD_FILE."