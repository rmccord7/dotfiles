#!/usr/bin/zsh

set -o errexit
set -o nounset
set -o pipefail



#######################################
# Finds the specified file from the specified directory
# up until root is reached.
#
# Symlinks are ignored.
#
# Parameters:
#   Directory - Specified directory.
#######################################
find_up() {

  # Handle input passed on command line.
  if [[ $# -eq 0 ]]; then
    echo "Usage $0: [DIR]"
    exit 1
  fi

  local dir="$1"

  while [[ $dir != / ]];
  do
      find "$dir" -maxdepth 1 -mindepth 1 "$@"

      # Go to parent (ignore sym links)
      dir="$(realpath -s "$dir"/..)"
  done
}
