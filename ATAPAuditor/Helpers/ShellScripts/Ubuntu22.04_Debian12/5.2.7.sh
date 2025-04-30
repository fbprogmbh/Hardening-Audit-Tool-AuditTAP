#!/usr/bin/env bash

# multiple groups can be configured to switch to diffrent set of users
while IFS='=' read -r _ confGroup; do
    # options not in specific Order -> cut of
    group="$(echo $confGroup | awk '{print $1}')"
    membercount=$(grep -Pi "^$group:" /etc/group | awk -F ':' '{print $NF}' | awk -F ',' '{print NF}')
    # groups should have no members
    [[ $membercount -gt 0 ]] && exit 1
done < <(grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su)

exit 0
