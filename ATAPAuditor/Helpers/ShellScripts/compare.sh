#!/bin/bash

# Check arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <dir1> <dir2>"
    exit 1
fi

dir1="$1"
dir2="$2"

# Ensure both arguments are directories
if [ ! -d "$dir1" ] || [ ! -d "$dir2" ]; then
    echo "Both arguments must be directories."
    exit 1
fi

# Iterate over files in dir1
find "$dir1" -type f | while read -r file1; do
    # Get the relative path of the file in dir1
    relpath="${file1#$dir1/}"

    file2="$dir2/$relpath"

    # Check if the same relative file exists in dir2
    if [ -f "$file2" ]; then
        # Compare contents
        if cmp -s "$file1" "$file2"; then
            echo "$relpath"
        fi
    fi
done

