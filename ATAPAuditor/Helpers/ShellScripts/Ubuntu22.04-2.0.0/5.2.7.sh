#!/usr/bin/env bash

# multiple groups can be configured to switch to diffrent users
while IFS='=' read -r _ confGroup; do
    membercount=$(grep -Pi "^$confGroup:" /etc/group | awk -F ':' '{print $NF}' | awk -F ',' '{print NF}')
    # groups should have no members
    if [[ $membercount -gt 0 ]] ; then
        echo "Group \"$confGroup\" has members allowed to use su command."
        exit 1
    else
        echo "Group \"$confGroup\" has no members allowed to use su command."
    fi
done < <(grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su)

exit 0
