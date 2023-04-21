#!/bin/bash

# Define the backup directory
BACKUP_DIR=/backup

# Create the backup directory if it doesn't exist
if [ ! -d $BACKUP_DIR ]
then
        mkdir -p $BACKUP_DIR
fi

# Create the backup
tar -czf $BACKUP_DIR/$(date +%Y%m%d-%H%M%S)_full_backup.tar.gz --exclude=$BACKUP_DIR / > /dev/null 2>&1

echo "Full system backup created at $BACKUP_DIR"



# This script creates a backup directory and a full system backup using tar command with gzip compression to save space. 
# The --exclude option is used to exclude the backup directory from the backup, preventing an infinite loop. 
# The > /dev/null 2>&1 at the end of the command is used to hide the output of the command, so the script runs faster.

# This script can be run manually or added to a cron job to run automatically.
# If you want to run the script automatically, add the following line to your crontab file (crontab -e) to run the script at midnight on the first day of every month:
# 0 0 1 * * /path/to/backup_script.sh
