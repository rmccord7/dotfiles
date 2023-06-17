#!/usr/bin/zsh

# Exit immediately if command exist with non-zero status
set -e

# Store the specified path
dir="$1"

# Truncate used path parameter
shift 1

# While the specified path is not root.
while [[ $dir != / ]];
do
    # Find the specified file
    find "$dir" -maxdepth 1 -mindepth 1 "$@"

    # Go to parent (ignore sym links)
    dir="$(realpath -s "$dir"/..)"
done
