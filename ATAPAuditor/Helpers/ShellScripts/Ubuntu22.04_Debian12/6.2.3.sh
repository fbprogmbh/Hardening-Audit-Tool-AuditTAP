#!/bin/bash

for i in $(cut -s -d: -f4 /etc/passwd | sort -u); do
    grep -q -P "^.*?:[^:]*:$i:" /etc/group || exit 1
done
