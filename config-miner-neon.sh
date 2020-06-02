#!/usr/bin/env bash
# Script created 2020-06-02 by WhoaBuddy
# Hosted on GitHub by AbsorbingChaos
# Link: https://github.com/AbsorbingChaos/bks-setup-miner
# Based on Bash3 Boilerplate. Copyright (c) 2014, kvz.io
# Link: https://kvz.io/blog/2013/11/21/bash-best-practices/

###############
# INIT SETUP  #
###############

set -o errexit
set -o pipefail
set -o nounset

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app
