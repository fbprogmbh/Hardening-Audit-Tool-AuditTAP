#!/usr/bin/env bash

config_files=("/etc/rsyslog.conf" "/etc/rsyslog.d/*.conf")
expected_value=0640

for file in ${config_files[@]}; do
	for i in $file; do
		if grep -qE '^\s*\$FileCreateMode' "$i" 2>/dev/null; then
			chosen_file=$i
		fi
	done
done
if [[ -n $chosen_file ]]; then
	current_value=$(grep -E '^\s*\$FileCreateMode' "$chosen_file" | sed -E 's/^\s*\$FileCreateMode\s+//')
	if [[ -n $current_value && $current_value -le $expected_value ]]; then
		echo "FileCreateMode is restricted enough"
		exit 0
	else
		echo "FileCreateMode is not restricted enough"
		exit 1
	fi
else
	exit 1
fi
