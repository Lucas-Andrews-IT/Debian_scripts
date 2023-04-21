#!/bin/bash

# Define the backup directory
BACKUP_DIR=/backup

# Create the backup directory if it doesn't exist
if [ ! -d $BACKUP_DIR ]
then
        mkdir -p $BACKUP_DIR
fi

# Check if a full backup exists
FULL_BACKUP=$(ls -1t $BACKUP_DIR/*_full_backup.tar.gz 2>/dev/null | head -n1)
if [ -z "$FULL_BACKUP" ]
then
        # Full backup doesn't exist, create a full backup
        tar -czf $BACKUP_DIR/$(date +%Y%m%d-%H%M%S)_full_backup.tar.gz --exclude=$BACKUP_DIR / > /dev/null 2>&1
else
        # Full backup exists, create a differential backup
        tar -czf $BACKUP_DIR/$(date +%Y%m%d-%H%M%S)_diff_backup.tar.gz --exclude=$BACKUP_DIR -g <(find / -path $BACKUP_DIR -prune -o -type f -print0 | xargs -0 stat --format '%Y %n' | sort -nr | cut -d' ' -f2-) > /dev/null 2>&1
fi

echo "Backup created at $BACKUP_DIR"


# This script checks if a full backup exists in the backup directory, and creates a full backup if it doesn't exist. 
# Otherwise, it creates a differential backup using the -g option of the tar command to only include files that have been modified since the last backup. 

# This script can also be added to a cron job to run automatically every 7 days: 0 0 * * 0 /path/to/backup_script.sh
