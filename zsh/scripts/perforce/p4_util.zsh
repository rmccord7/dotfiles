#!/usr/bin/zsh

set -o errexit
set -o nounset
set -o pipefail

source log.zsh
source util.zsh

# Globals
init=false

#######################################
#
# Prints p4 command location and p4 environment variables.
#
#######################################
p4_print_env () {

  echo "P4:       $(where p4 | head -n 1)"
  echo "P4USER:   $P4USER"
  echo "P4HOST:   $P4HOST"
  echo "P4PORT:   $P4PORT"
  echo "P4CLIENT: $P4CLIENT"

}

#######################################
#
# Initializes this module
#
#######################################
p4_verify_env () {

  # Make sure p4 is supported
  if ! command -v p4 > /dev/null; then
    log_error "P4 not found."
  fi

  if [[ -z $P4USER ]]; then
    log_error "P4 user not set."
  fi

  if [[ -z $P4HOST ]]; then
    log_error "P4 host not set."
  fi

  if [[ -z $P4PORT ]]; then
    log_error "P4 port not set."
  fi

  if [[ -z $P4CLIENT ]]; then
    log_error "P4 client not set."
  fi
}

#######################################
# Verifys a perforce CL is a number or the default
# changelist.
#
# Parameters:
#   CL#
#
#######################################
p4_verify_cl () {

  local cl="$1"
  shift 1

  local num_check_re='^[0-9]+$'

  if ! [[ $cl =~ $num_check_re || $cl == 'default' ]]; then

    log_error "Failed to verify CL#$cl"
  fi
}

#######################################
# Finds p4 config.
#
#######################################
p4_find_p4_config () {

  # Start from the cwd directory
  cur_dir="."

  # While the specified path is not root.
  while [[ $cur_dir != / ]]; do

      # Find the specified file
      if [[ -n $(find $cur_dir -maxdepth 1 -mindepth 1 -name "${P4CONFIG}") ]]; then

        echo "{cur_dir}"
        exit 0
      fi

      # Go to parent (ignore sym links)
      cur_dir="$(realpath -s "$cur_dir"/..)"
  done

  exit 1
}

#######################################
# Converts a list of depot spec files to file
# spec.
#
# Parameters:
#   List of p4 files in depot spec
#
# Output:
#   List of p4 files in file spec
#
#######################################
p4_convert_depot_to_file_spec () {

  p4 -ztag -x - where | grep '... path ' | sed 's/\.\.\. path //'

}

#######################################
# Converts a list of file spec files to depot
# spec.
#
# Parameters:
#   List of p4 files in depot spec
#
# Output:
#   List of p4 files in file spec
#
#######################################
p4_convert_file_to_depot_spec () {

  p4 -ztag -x - where | grep '... depotFile ' | sed 's/\.\.\. depotFile //'

}

#######################################
# Gets the information for a CL
#
# This function cannot get contents for the 'default' CL.
#
# Parameters:
#   CL - Change list
#######################################
p4_get_cl_info () {

  # Verify parameters
  if [[ $# -eq 0 ]] ; then
    log_error "Invalid number of parameters."
  fi

  # Store parameters
  local cl="$1"
  shift 1

  # Verify we have a valid CL.
  p4_verify_cl "${cl}"

  # Verify the cl belongs to the current user and is for the
  # current client.
  local cl_info="$(p4 describe -s "${cl}")"

  if [[ $? != 0 ]]; then
    log_error "Failed to get CL#"${cl}" contents."
  fi

  echo "$cl_info"
}


#######################################
# Deletes a CL
#
# Parameters:
#   CL#
#
# Returns:
#   0 for success. Non-zero for failure.
#######################################
p4_delete_cl () {

  local cl="$1"
  shift 1

  local args="$@"

  # Delete shelve files
  p4_cmd_shelve "${cl}" -d

  # Revert files
  p4_revert_cl "${cl}"

  # Delete the CL
  p4_cmd_change "${cl}" -d
}
