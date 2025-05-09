#!/usr/bin/env bash

if [[ ! -d "/etc/authselect" && ! -d "/usr/share/authselect" ]]; then
	echo "Authselect is not installed. Exiting."
	exit 1
fi

pam_profile="$(head -1 /etc/authselect/authselect.conf 2>/dev/null || echo "default")"

if [[ "$pam_profile" =~ ^custom/ ]]; then
	pam_profile_path="/etc/authselect/$pam_profile"
else
	pam_profile_path="/usr/share/authselect/default/$pam_profile"
fi

for auth_file in "$pam_profile_path"/{password-auth,system-auth}; do
	if grep -Eq '^\s*password\s+([^#\n\r]+\s+)?pam_unix\.so\b' $auth_file | grep -Pv '\bremember=\d\b'; then
		echo "- \"remember\" is set in $auth_file"
		exit 1
	else
		echo "- \"remember\" is not set in $auth_file"
	fi
done
exit 0
