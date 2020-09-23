# Simple backup scripts for Nextcloud

These are the backup scripts I use for backing up my Nextcloud files on my server, which is a Raspberry Pi 4B.
The scripts make a daily backup, a weekly backup based on the latest daily backup and a compressed monthly backup, also based on the latest daily backup.

## How to use
Just modify the directories paths according to your installation path. Also note down the user and password of Nextcloud's database.
The daily and weekly backups use [rsync](url:https://linux.die.net/man/1/rsync) to backup data, even if it is technically a "syncing" of the two folders. Pay attention to the rsync sintax to avoid deleting your source folder!


## Adding the cron job
In order to run the scripts automatically when desired, add a [cron job](https://man7.org/linux/man-pages/man5/crontab.5.html) to /etc/crontab, similar to this:

```bash
30 2 * * * /home/pi/Documents/Scripts/Backup/Nextcloud/nextcloud-backup-daily.sh
35 2 * * 6 /home/pi/Documents/Scripts/Backup/Nextcloud/nextcloud-backup-weekly.sh
0 3 28 * * /home/pi/Documents/Scripts/Backup/Nextcloud/nextcloud-backup-monthly.sh
```

## Checking scripts
- `check-pid.sh`: checks if there is another backup process running and waits until it has finished
- `check-source-hdd.sh`: checks if the source hdd is up and running
- `check-destination-hdd.sh`: checks the destination hdd

## Future work for contributors!
These backup scripts could be made better and better until an official solution for Nextcloud is provides. Here are some ideas:
- [ ] Create a `.txt` file for making source and destination directories more easily changeable
- [ ] Create a log file for errors
- [ ] Check remaining space in the destination and possibily delete old compressed archives
- [ ] Password protect / encryption for enhanced security

