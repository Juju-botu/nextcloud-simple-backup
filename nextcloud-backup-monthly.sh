#!/bin/bash

# Remove PID file before exiting!
PIDFILE=/home/pi/Documents/Scripts/Backup/Nextcloud/backup.pid

# Import check-PID script
source /home/pi/Documents/Scripts/Backup/Nextcloud/check-pid.sh

# Check mountpoint
source /home/pi/Documents/Scripts/Backup/Nextcloud/check-dest-hdd.sh

# Backup script for nextcloud
BAK_DEST=/media/backup/Nextcloud/Monthly # need to add specific folders
BAK_SRC=/media/backup/Nextcloud/Daily/
BAK_DATE=$(date +"%F")
BAK_NAME=nextcloud-monthly-backup_$BAK_DATE

# No need maintenance mode for nextcloud

# Backup netcloud daily, tar.gz and move BEWARE tar DEST SOURCE
echo "Backing up latest daily backup. This may take a while..."
tar -cvjf $BAK_DEST/$BAK_NAME.tar.bz2 $BAK_SRC
echo "Done!"

rm $PIDFILE
