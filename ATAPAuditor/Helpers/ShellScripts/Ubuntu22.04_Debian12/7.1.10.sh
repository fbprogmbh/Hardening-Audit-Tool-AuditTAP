#!/usr/bin/env bash

pathOpass='/etc/security/opasswd'
pathOpassOld='/etc/security/opasswd.old'

for p in "$pathOpass" "$pathOpassOld"; do
    if [[ -e $p ]]; then
        read a u g < <(stat -c '%#a %u %g' $p)
        [[ $((a & 0177)) -gt 0 || $u -ne 0 || $g -ne 0 ]] && exit 1
    fi
done

exit 0