#!/usr/bin/env bash
#####  NOT TESTED PROPERLY, THIS SCRIPT COULD BE CHANGED IN THE FUTURE #####
smask="01000"

ignored_paths=(
	"/run/user/*"
	"/proc/*"
	"*/containerd/*"
	"*/kubelet/pods/*"
	"/sys/*"
	"/snap/*"
)

while read -r path; do
	ignored_paths+=("$path/*")
done < <(findmnt -Dkerno fstype,target | awk '$1 ~ /^(nfs|proc|smb|vfat)$/ {print $2}')

world_writable_files=$(find / \( ! -path "${ignored_paths[0]}" $(printf " -a ! -path %s" "${ignored_paths[@]:1}") \) \
	-type f -perm -0002 2>/dev/null)

world_writable_dirs=$(find / -type d -perm -0002 ! -perm -$smask $(printf " -a ! -path '%s' " "${ignored_paths[@]}") 2>/dev/null)

if [ -n "$world_writable_files" ]; then
	exit 1
fi

if [ -n "$world_writable_dirs" ]; then
	exit 1
fi

exit 0
