#!/bin/bash

# Check if source hdd is mounted. Try to mount
mount -a

if grep -qs '/media/hdd' /proc/mounts
then
	echo "HDD found and correctly mounted"
else
	echo "Source HDD not mounted. Skipping backup..."
    # Should write to log here...
	exit 1
fi
