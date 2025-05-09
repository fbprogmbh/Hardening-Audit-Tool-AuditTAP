#!/usr/bin/env bash

if grep -i SELINUX=enforcing /etc/selinux/config; then
	exit 0
else
	exit 1
fi
