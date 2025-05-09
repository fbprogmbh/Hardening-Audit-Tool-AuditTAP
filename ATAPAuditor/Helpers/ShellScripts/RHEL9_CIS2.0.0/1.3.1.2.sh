#!/usr/bin/env bash

if grubby --info=ALL | grep -Pq '(selinux|enforcing)=0\b'; then
	exit 1
else
	exit 0
fi
