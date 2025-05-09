#!/usr/bin/env bash

for file in /etc/systemd/coredump.conf /etc/systemd/coredump.conf.d/*.conf; do
	[ -e "$file" ] || continue

	if grep -Eq '^\s*ProcessSizeMax=0' "$file"; then
		exit 0
	fi

done

exit 1
