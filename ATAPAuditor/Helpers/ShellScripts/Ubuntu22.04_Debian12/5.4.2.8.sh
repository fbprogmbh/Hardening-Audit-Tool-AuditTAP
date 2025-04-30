#!/usr/bin/env bash

valid_shells="^($(awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//p' | paste -s -d '|' - ))$"
while IFS= read -r user; do
    passwd -S "$user" | awk '$2 !~ /^L/ {print "Account: \"" $1 "\" does not have a valid login shell and is not locked"}'
done < <(awk -v pat="$valid_shells" -F: '($1 != "root" && $(NF) !~ pat) {print $1}' /etc/passwd)

exit 0