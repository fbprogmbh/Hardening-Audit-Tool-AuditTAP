#!/usr/bin/env bash

if grep -Eq '^\s*SELINUXTYPE=(targeted|mls)\b' /etc/selinux/config; then
	echo "SELinux-Type is configured correctly"
	exit 0
else
	echo "ERROR: SELinux-Type not configured"
	exit 1
fi

if sestatus | grep -q "Loaded policy name: targeted"; then
	echo "Policy is'targeted'"
	exit 0
elif sestatus | grep -q "Loaded policy name: mls"; then
	echo "ERROR: Policy is 'mls'"
	exit 1
else
	echo "ERROR: policy should be 'targeted'"
	exit 1
fi
