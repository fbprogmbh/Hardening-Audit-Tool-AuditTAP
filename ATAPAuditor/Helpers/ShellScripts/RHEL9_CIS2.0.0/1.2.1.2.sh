#!/usr/bin/env bash
# Configuration file to check
FILE="/etc/dnf/dnf.conf"
# Pattern to search for
PATTERN="gpgcheck"

# Check if the configuration file exists
if [ ! -f "$FILE" ]; then
	echo "File $FILE not found."
	exit 1
fi

# Search for the pattern, whether it's commented or not
grep -E "^[[:space:]]*#?[[:space:]]*$PATTERN\s*=" "$FILE" >/dev/null
FOUND=$?

# If the pattern is found
if [ $FOUND -eq 0 ]; then
	# Check if the pattern is commented
	grep -E "^[[:space:]]*#[[:space:]]*$PATTERN\s*=" "$FILE" >/dev/null
	COMMENTED=$?

	if [ $COMMENTED -eq 0 ]; then
		echo "Pattern $PATTERN is commented."
		exit 1
	fi

	# Extract the value of gpgcheck using grep and sed
	VALUE=$(grep -E "^[[:space:]]*$PATTERN\s*=\s*(true|yes|[0-9]+)" "$FILE" | sed -E 's/.*=\s*(true|yes|[0-9]+).*/\1/')

	# If the value was found and it's valid (true, yes, or 1)
	if [[ "$VALUE" == "true" || "$VALUE" == "yes" || "$VALUE" == "1" ]]; then
		echo "The value of $PATTERN ($VALUE) is valid."
		exit 0
	else
		echo "The value of $PATTERN ($VALUE) is not valid."
		exit 1
	fi
else
	echo "Pattern $PATTERN not found."
	exit 1
fi
