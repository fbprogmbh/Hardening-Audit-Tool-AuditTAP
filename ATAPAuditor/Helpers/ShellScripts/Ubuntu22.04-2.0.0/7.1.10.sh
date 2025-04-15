#!/usr/bin/env bash

pathOpass='/etc/security/opasswd'
pathOpassOld='/etc/security/opasswd.old'

for p in "$pathOpass" "$pathOpassOld"; do
    if [[ -e $p && ! "$(stat -c '%a %u %g' $p)" = "600 0 0" ]]; then
        exit 1
    fi
done

exit 0