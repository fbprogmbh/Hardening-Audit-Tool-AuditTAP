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

checkLock() {
    l_gdmfile="$(grep -Prils "^\h*$1\h*=\h*\d+\b" /etc/dconf/db/*.d)" # can be multipale
    if [[ -n "$l_gdmfile" ]]; then
        for path in $(dirname $l_gdmfile); do
            grep -Prisq "^\h*\/org\/gnome\/desktop\/$2\/$1\b" "$path/locks" || exit 1
        done
    else
        exit 1
    fi
}

if [[ $found -eq 0 ]]; then
    checkLock "idle-delay" "session"
    checkLock "lock-delay" "screensaver"
fi

exit 0
