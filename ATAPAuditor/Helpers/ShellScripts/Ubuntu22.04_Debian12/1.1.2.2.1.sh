#!/usr/bin/env bash

CHECK_DIR="/dev/shm"
findmnt -kn "$CHECK_DIR" &>/dev/null
exit $?