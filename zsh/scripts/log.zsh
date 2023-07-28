#!/usr/bin/zsh

set -o errexit
set -o nounset
set -o pipefail

DEBUG=${DEBUG:-}
INFO=${INFO:-}

#######################################
# Logs error messages
#######################################
log_error () {
  echo -e "[ERROR]: $*"
  exit 1
}

#######################################
# Logs debug messages
#######################################
log_debug () {
  if [[ "${DEBUG}" == 1 ]]; then
    echo -e "[DEBUG]: $*"
  fi
}

#######################################
# Logs info messages
#######################################
log_info () {
  if [[ "${INFO}" == 1 ]]; then
    echo -e "[INFO]: $*"
  fi
}
