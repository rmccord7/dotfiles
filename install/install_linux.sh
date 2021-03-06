#!/usr/bin/env bash

set -e

SUFFIX=".conf.yaml"
CONFIG="yaml/linux${SUFFIX}"

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOTBOT_DIR="../dotbot"
DOTBOT_BIN="bin/dotbot"

#echo "BASH_SOURCE: ${BASH_SOURCE[0]}"
#echo "BASEDIR: ${BASEDIR}"
#echo "DOTBOT_DIR: ${DOTBOT_DIR}"

cd "${BASEDIR}"
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"

"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}/.." -c "${CONFIG}" "${@}"

source /etc/os-release
case $ID in
  arch)
    echo "arch"
      "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}/.." -c "yaml/${ID}${SUFFIX}" --plugin-dir "${BASEDIR}/../dotbot-yay" "${@}"
      ;;
  ubuntu)
    echo "ubuntu"
      "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}/.." -c "yaml/${ID}${SUFFIX}" --plugin-dir "${BASEDIR}/../dotbot-apt" "${@}"
      ;;
  *)
    echo "Unknown distro ID: $ID"
esac

