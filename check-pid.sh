#!/bin/bash

# PID file management: as long as there is a PID file running, we 
# do not execute and wait for it to finish

PIDFILE=/home/pi/Documents/Scripts/Backup/Nextcloud/backup.pid

if [ -f $PIDFILE ]
then 
	PID=$(cat $PIDFILE)
  echo "Previous backup's PID: $PID"
 	while ps -p $PID > /dev/null 2>&1
 	do
		echo "Another backup is running. Waiting..."
		sleep 10
	done
 	echo $$ > $PIDFILE
	if [ $? -ne 0 ] 
	then
		echo "Could not create PID file"
   		exit 1
	fi
else
	echo $$ > $PIDFILE
	if [ $? -ne 0 ]
	then
		echo "Could not create PID FILE"
 		exit 1
	fi
fi
