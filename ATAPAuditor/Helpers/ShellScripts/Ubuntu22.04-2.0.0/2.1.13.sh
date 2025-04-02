#!/usr/bin/env bash

PATTERN='rsyncd?\.service|rsyncd\.socket'

# DebUntu rsync.service
# rhel rsyncd.service und rsyncd.socket
services=$(systemctl list-unit-files | grep -oE $PATTERN)
for service in $services;
do
	if systemctl is-enabled $service 1>/dev/null 2>/dev/null; then
		exit 1
	fi
done

exit 0
