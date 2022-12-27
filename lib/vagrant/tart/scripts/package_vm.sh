#!/usr/bin/env bash

set -eo pipefail

VM_NAME=$1

VM_PATH="~/.tart/vms/${VM_NAME}"

if [[ ! -d "${VM_PATH}" ]]; then
    return 1
fi

# zip up folders contents, minus any process ID data,
# the only files from Tart we want are:
# - `config.json`
# - `nvram.bin`
# - `disk.img`

# echo the zip file path for vagrant and return 0

return 0
