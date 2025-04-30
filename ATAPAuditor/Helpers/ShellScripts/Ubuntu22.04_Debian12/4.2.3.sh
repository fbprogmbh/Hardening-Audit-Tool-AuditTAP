#!/usr/bin/env bash

checkForRules() {
    # check if a Block states at least 1 reference (ufw blocks)
    # and has more 2 lines (Input, Output, Forward blocks)
    $1 -L | awk -v RS="\n\n" '$0 !~ /\(0 references\)/ && $0 ~ /.+\n.+\n.+/ {print $0}'
}

[[ -n "$(checkForRules ip6tables)" || -n "$(checkForRules iptables)" ]] && exit 1

exit 0