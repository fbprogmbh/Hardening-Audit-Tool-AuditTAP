#!/usr/bin/env bash

which ufw &>/dev/null || echo "no ufw" && exit 0

ufw_out="$(ufw status verbose)"
ss -tuln | awk '($5!~/%lo:/ && $5!~/127.0.0.1:/ && $5!~/::1/) {split($5, a, ":"); print a[2]}' | sort | uniq | while read -r lpn; do
    ! grep -Pq "^\h*$lpn\b" <<<"$ufw_out" && echo "- Port: \"$lpn\" is missing a firewall rule"
done
