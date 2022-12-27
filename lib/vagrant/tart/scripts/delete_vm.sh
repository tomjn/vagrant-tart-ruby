#!/usr/bin/env bash

set -eo pipefail

VM_NAME=$1

# delete the VM, use Tarts response code to signal success/failure
tart delete "${VM_NAME}"
