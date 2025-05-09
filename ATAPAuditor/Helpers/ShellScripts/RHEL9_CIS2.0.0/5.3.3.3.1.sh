#!/usr/bin/env bash
pw_file="/etc/security/pwhistory.conf"
value="remember"
regex_pattern="^\s*${value}\s*=\s*[0-9]+\s*$"
expected_value=24
if grep -Eq "$regex_pattern" "$pw_file"; then
	current_value=$(grep -Eo "$regex_pattern" "$pw_file" | awk -F'=' '{print $2}' | tr -d ' ')
	if ((current_value < expected_value)); then
		echo "ERROR: $value = $current_value < $expected_value"
		exit 1
	else
		echo "$value = $current_value > $expected_value"
		exit 0
	fi
else
	exit 1
fi
