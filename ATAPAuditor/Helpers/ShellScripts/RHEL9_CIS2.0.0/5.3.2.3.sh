#!/usr/bin/env bash

# Check if /etc/authselect/authselect.conf exists
if [[ ! -f /etc/authselect/authselect.conf ]]; then
	echo "/etc/authselect/authselect.conf is missing."
	exit 1
fi

l_module_name="unix"
l_pam_profile="$(head -1 /etc/authselect/authselect.conf)"

if grep -Pq -- '^custom\/' <<<"$l_pam_profile"; then
	l_pam_profile_path="/etc/authselect/$l_pam_profile"
else
	l_pam_profile_path="/usr/share/authselect/default/$l_pam_profile"
fi

for file in "$l_pam_profile_path/password-auth" "$l_pam_profile_path/system-auth"; do
	if [[ ! -f "$file" ]]; then
		echo "File $file does not exist. Test failed."
		exit 1
	fi

	if ! grep -P -- "\bpam_$l_module_name\.so\b" "$file" >/dev/null; then
		echo "pam_unix.so entry not found in $file. Test failed."
		exit 1
	else
		echo "pam_unix.so entry found in $file. Test passed."
	fi
done

exit 0
