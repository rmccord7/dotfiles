#!/usr/bin/zsh

# Start from the root directory
current_dir="."

# While the specified path is not root.
while [[ $current_dir != / ]];
do
    # Find the specified file
    if [[ -n $(find $current_dir -maxdepth 1 -mindepth 1 -name ".p4config") ]]
    then
      # Set P4 client
      echo "$(cat ".p4config" | grep "P4CLIENT" | cut -d "=" -f 2)"
      exit 0
    fi

    # Go to parent (ignore sym links)
    current_dir="$(realpath -s "$current_dir"/..)"
done

