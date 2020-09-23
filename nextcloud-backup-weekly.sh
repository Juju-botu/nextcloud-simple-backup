#!/bin/bash
 
# Remove PID file before exiting!
PIDFILE=/home/pi/Documents/Scripts/Backup/Nextcloud/backup.pid

# Import check-PID script
source /home/pi/Documents/Scripts/Backup/Nextcloud/check-pid.sh

# Check mountpoint
source /home/pi/Documents/Scripts/Backup/Nextcloud/check-dest-hdd.sh

# Backup weekly script for nextcloud (everything on the HDD)
BAK_DEST=/media/backup/Nextcloud/Weekly # need to add specific folders
BAK_SRC=/media/backup/Nextcloud/Daily/
BAK_DATE=$(date +"%F")

# No need to enable maintenance mode on Nextcloud: backing up the backup

# Backup latest daily to weekly
echo "Backing up latest daily backup. This may take a while..."
rsync --delete --progress -Aavx $BAK_SRC $BAK_DEST
echo "Done!"

rm $PIDFILE
