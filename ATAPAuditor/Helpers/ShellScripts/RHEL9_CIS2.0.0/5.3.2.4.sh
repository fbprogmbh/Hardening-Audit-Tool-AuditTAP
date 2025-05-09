#!/usr/bin/env bash

# Check if authselect.conf exists
if [[ ! -f /etc/authselect/authselect.conf ]]; then
	echo "/etc/authselect/authselect.conf is missing."
	exit 1
fi

l_module_name="pwhistory"
l_pam_profile="$(head -1 /etc/authselect/authselect.conf)"

# Check if authselect.conf exists
if [[ ! -f /etc/authselect/authselect.conf ]]; then
	echo "/etc/authselect/authselect.conf is missing."
	exit 0
fi

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
		echo "pam_pwhistory.so entry not found in $file. Test failed."
		exit 1
	else
		echo "pam_pwhistory.so entry found in $file."
	fi

	if ! grep -P -- "\{include if \"with-pwhistory\"\}" "$file" >/dev/null; then
		echo "Entry '{include if \"with-pwhistory\"}' not found in $file. Test failed."
		exit 1
	else
		echo "Entry '{include if \"with-pwhistory\"}' found in $file. Test passed."
	fi
done

exit 0
