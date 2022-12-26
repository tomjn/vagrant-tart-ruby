#!/usr/bin/env bash

set -eo pipefail

VM_NAME=$1

tart delete "${VM_NAME}"
