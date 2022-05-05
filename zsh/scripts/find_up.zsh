#!/bin/zsh

# Exit immediately if command exist with non-zero status
set -e

# Store the specified path
path="$1"

# Truncate used path parameter
shift 1

# While the specified path is not root.
while [[ $path != / ]];
do
    # Find the specified file
    find "$path" -maxdepth 1 -mindepth 1 "$@"

    # Go to parent (ignore sym links)
    path="$(realpath -s "$path"/..)"
done
