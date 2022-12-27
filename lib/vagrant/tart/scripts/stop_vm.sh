#!/usr/bin/env bash

set -eo pipefail

VM_NAME=$1

# halt VM and use Tarts return code
tart stop "${VM_NAME}"
