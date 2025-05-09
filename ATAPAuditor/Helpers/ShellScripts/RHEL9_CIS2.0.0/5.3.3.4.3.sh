#!/usr/bin/env bash

config_file="/etc/authselect/authselect.conf"
if [[ ! -f "$config_file" || ! -r "$config_file" ]]; then
	echo "Configuration file '$config_file' is missing or not readable. Exiting."
	exit 1
fi

if command -v authselect &>/dev/null; then
	pam_profile="$(head -1 /etc/authselect/authselect.conf 2>/dev/null || echo "default")"

	if [[ "$pam_profile" =~ ^custom/ ]]; then
		pam_profile_path="/etc/authselect/$pam_profile"
	else
		pam_profile_path="/usr/share/authselect/default/$pam_profile"
	fi
else
	pam_profile_path="/etc/pam.d"
fi

for auth_file in "$pam_profile_path"/{password-auth,system-auth}; do
	if grep -Eq '^\s*password\s+[^#]*pam_unix\.so\s+.*(sha512|yescrypt)\b' $auth_file; then
		echo "- strong password hashing algorithm is set in $auth_file"
	else
		echo "- strong password hashing algorithm is not set in $auth_file"
		exit 1
	fi
done
exit 0
