#!/usr/bin/env bash
grep -q "^1$" /proc/sys/crypto/fips_enabled && exit 0
grep -q "^LEGACY$" /etc/crypto-policies/config && exit 1 || exit 0
