#!/usr/bin/env bash

set -eo pipefail

VM_NAME=$1

tart run "${VM_NAME}" --no-graphics

return 0
