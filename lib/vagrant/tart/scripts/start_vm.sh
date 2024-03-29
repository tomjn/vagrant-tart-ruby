#!/usr/bin/env bash

set -eo pipefail

VM_NAME=$1

# start Tart VM async

nohup tart run "${VM_NAME}" --no-graphics >/dev/null 2>&1 &

# wait a short period

sleep 3

# check that the process is still running,
#  if it is
#    grab the process ID and return 0
#    if it is not return 1

return 0
