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
    l_gdmfile="$(grep -Prils "^\h*idle-delay\h*=\h*\d+\b" /etc/dconf/db/*.d)" # can be multipale
    if [[ -n "$l_gdmfile" ]]; then
        for path in $(dirname $l_gdmfile); do
            grep -Prisq '^\h*\/org\/gnome\/desktop\/session\/idle-delay\b' "$path/locks" || exit 1
        done
    else
        exit 1
    fi
    l_gdmfile="$(grep -Prils "^\h*lock-delay\h*=\h*\d+\b" /etc/dconf/db/*.d)" # can be multipale
    if [[ -n "$l_gdmfile" ]]; then
        for path in $(dirname $l_gdmfile); do
            grep -Prisq '^\h*\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$path/locks" || exit 1
        done
    else
        exit 1
    fi
fi

exit 0
