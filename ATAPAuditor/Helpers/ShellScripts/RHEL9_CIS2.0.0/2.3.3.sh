#!/usr/bin/env bash

config_file="/etc/sysconfig/chronyd"

if [[ ! -f "$config_file" || ! -r "$config_file" ]]; then
	echo "Configuration file '$config_file' is missing or not readable. Exiting."
	exit 1
fi

regex_pattern="^\s*OPTIONS=\s*([^#\n\r]+\s+)?-u\s+root\b"
value="-u\s+root\b"
if grep -Eq "$regex_pattern" "$config_file"; then
	echo " \"$value\" in $config_file is found"
	exit 1
else
	echo "\"$value\" not found or not set "
fi
exit 0
