#!/usr/bin/env bash

sufile="/etc/sudoers"
includes=$(awk '/^[^#]*(@|#)include(dir)?/{
	if ($1 ~ /^(@|#)includedir/)
		print $2"/*";
	else print $2}' $sufile)

for file in $sufile $includes; do
    # exclude hardening file
	if [[ ! $file =~ /\*$ ]] && grep -q "^[^#]*NOPASSWD" $file && [[ $file != "/etc/sudoers.d/DSC" ]]; then
		exit 1
	fi
done

exit 0
