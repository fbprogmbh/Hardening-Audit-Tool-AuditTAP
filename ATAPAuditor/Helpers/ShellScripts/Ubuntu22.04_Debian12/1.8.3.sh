#!/usr/bin/env bash

if command -v dpkg-query >/dev/null 2>&1; then
    l_pq="dpkg-query -W"
elif command -v rpm >/dev/null 2>&1; then
    l_pq="rpm -q"
fi

found=1
for gdm in "gdm" "gdm3"; do # Space seporated list of packages to check
    $l_pq $gdm &>/dev/null && found=0
done

if [[ $found -eq 0 ]]; then
    l_gdmfile="$(grep -Prils '^\h*disable-user-list\h*=\h*true\b' /etc/dconf/db/*.d)" # can be multipale
    if [[ -n "$l_gdmfile" ]]; then
        l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<<"$l_gdmfile")" # can be multipale
        for prof in $l_gdmprofile; do
            # -r because local db config rules etc. can be listet under /etc/dconf/profile/user or others
            grep -Prq "^\h*system-db:$prof" /etc/dconf/profile/ || exit 1
            [ -f "/etc/dconf/db/$prof" ] || exit 1
        done
    else
        exit 1
    fi
fi

exit 0
