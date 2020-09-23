#!/bin/bash

# Check if destination hdd is mounted. Try to mount
mount -a

if grep -qs '/media/backup' /proc/mounts
then
	echo "HDD found and correctly mounted"
else
	echo "Destination HDD not mounted. Skipping backup..."
    # Should write to log here...
	exit 1
fi
