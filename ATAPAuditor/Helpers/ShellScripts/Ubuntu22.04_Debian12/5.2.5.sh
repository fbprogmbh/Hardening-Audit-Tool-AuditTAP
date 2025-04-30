#!/usr/bin/env bash

sufile="/etc/sudoers"
includes=$(awk '/^[^#]*(@|#)include(dir)?/{
	if ($1 ~ /^(@|#)includedir/)
		print $2"/*";
	else print $2}' $sufile)

for file in $sufile $includes; do
	if [[ ! $file =~ /\*$ ]] && grep -q "^[^#]*!authenticate" $file; then
		exit 1
	fi
done

exit 0
