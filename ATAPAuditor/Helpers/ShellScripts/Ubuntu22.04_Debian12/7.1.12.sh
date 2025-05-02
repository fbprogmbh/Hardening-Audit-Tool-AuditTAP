#!/usr/bin/env bash
#####  NOT TESTED PROPERLY, THIS SCRIPT COULD BE CHANGED IN THE FUTURE #####

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

unowned=$(find / -xdev \( ! -path "${ignored_paths[@]}" \) -type f,d \( -nouser -o -nogroup \) 2>/dev/null)

[[ -n $unowned ]] && exit 1

exit 0