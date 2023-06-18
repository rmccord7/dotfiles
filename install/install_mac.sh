#!/usr/bin/env bash

set -e

CONFIG="yaml/install.mac.conf.yaml"

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
