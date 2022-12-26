#!/usr/bin/env bash

set -eo pipefail

VM_NAME=$1

tart stop "${VM_NAME}"
