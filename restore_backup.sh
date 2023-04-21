#!/bin/bash

# Set the path to the backup file
BACKUP_PATH="/path/to/backup.tar.gz"

# Check if the backup file exists
if [ ! -f $BACKUP_PATH ]; then
  echo "Backup file not found!"
  exit 1
fi

# Stop any running services that could interfere with the restore process
service apache2 stop
service mysql stop

# Restore the system from the backup
tar -xvzf $BACKUP_PATH -C /

# Restart the services
service mysql start
service apache2 start

echo "System restore complete!"
