#!/bin/bash

# Remove PID file before exiting!
PIDFILE=/home/pi/Documents/Scripts/Backup/Nextcloud/backup.pid

# Import check-PID script
source /home/pi/Documents/Scripts/Backup/Nextcloud/check-pid.sh

# Check mount location for Nextcloud is OK, otherwise exit
# BEWARE: empty source folder results in file deletion at destination in rsync!
source /home/pi/Documents/Scripts/Backup/Nextcloud/check-src-hdd.sh
source /home/pi/Documents/Scripts/Backup/Nextcloud/check-dest-hdd.sh

# Backup script for nextcloud
BAK_DEST=/media/backup/Nextcloud/Daily # need to add specific folders
BAK_DATE=$(date +"%F")
BAK_INS_NAME=nextcloud-installation-backup_$BAK_DATE
BAK_DB_NAME=nextcloud-db-backup_$BAK_DATE
BAK_USERDATA_NAME=nextcloud-userdata-backup_$BAK_DATE
BAK_SHAREDATA_NAME=nextcloud-sharedata-backup_$BAK_DATE
DB_USERNAME=root
DB_PASSWORD=root

# Put Nextcloud into maintenance mode
sudo -u www-data /var/www/html/nextcloud/occ maintenance:mode --on

# Backup netcloud installation folder data, tar.gz and move
echo "Archiving installation folder..."
tar -czvf /tmp/$BAK_INS_NAME.tar.gz /var/www/html/nextcloud
echo "Done"
echo "Moving backup to HDD..."
mv /tmp/$BAK_INS_NAME.tar.gz $BAK_DEST/installation/
echo "Deleting previous backups..."
find $BAK_DEST/installation/ -type f ! -name $BAK_INS_NAME.tar.gz -delete
echo "Done"

# Backup nextcloud database
echo "Backing up database..."
mysqldump --user="$DB_USERNAME" --password="$DB_PASSWORD" nextcloud > /tmp/$BAK_DB_NAME.bak
mv /tmp/$BAK_DB_NAME.bak $BAK_DEST/databases/
echo "Deleting previous backups..."
find $BAK_DEST/databases/ -type f ! -name $BAK_DB_NAME.bak -delete
echo "Done"

# Backup users data !Beware --delete flag in rsync
echo "Backing up users data to HDD..."
sudo -u www-data rsync -Aavx --progress --delete /nextcloud/data $BAK_DEST/userdata/
echo "Done"

# Backup shared folders
echo "Backing up shared folders to HDD..."
sudo -u www-data rsync -Aavx --progress --delete --exclude Film --exclude Giochi --exclude 'Serie TV' --exclude Software /nextcloud/shared $BAK_DEST/shareddata/
echo "Done"

# Turn off maintenance mode to reactivate Nextcloud
sudo -u www-data /var/www/html/nextcloud/occ maintenance:mode --off
  
# Restart apache service
echo "Restarting Apache server..."
service apache2 restart
echo "Finished"

# PID file removal
rm $PIDFILE
