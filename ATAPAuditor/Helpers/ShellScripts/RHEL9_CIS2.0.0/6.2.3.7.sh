#!/usr/bin/env bash

config_files=("/etc/rsyslog.conf" "/etc/rsyslog.d/*.conf")

for file in "${config_files[@]}"; do
	for i in $file; do
		if [[ -f $i ]]; then
			if grep -qoE '^\s*module\(load="imtcp"\)' "$i" 2>/dev/null; then
				exit 1
			fi
			if grep -qoE '^\s*input\(type="imtcp"\s+port="[0-9]+"\)' "$i" 2>/dev/null; then
				exit 1
			fi
			if grep -qoE '^\s*\$ModLoad\s+imtcp' "$i" 2>/dev/null; then
				exit 1
			fi
			if grep -qoE '^\s*\$InputTCPServerRun' "$i" 2>/dev/null; then
				exit 1
			fi
		fi
	done
done
exit 0
