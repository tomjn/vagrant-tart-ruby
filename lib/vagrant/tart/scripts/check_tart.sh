#!/usr/bin/env bash

set -eo pipefail

if command -v tart &> /dev/null; then
    return 0
fi

return 1
