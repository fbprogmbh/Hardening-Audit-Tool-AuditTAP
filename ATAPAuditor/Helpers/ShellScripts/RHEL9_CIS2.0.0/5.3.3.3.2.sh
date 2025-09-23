#!/usr/bin/env bash

pw_file="/etc/security/pwhistory.conf"

value="enfore_for_root"

regex_pattern="^\s*#*\s*${value}\s*"

if grep -Eq "^\s*${value}\s*$" "$pw_file"; then
	echo "$value is correctly set."
	exit 0
else
	echo "ERROR: $value is either missing or commented out."
	exit 1
fi
