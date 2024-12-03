#!/usr/bin/env bash

set -euo pipefail

cd "${directory}"

git remote set-url "${name}" "${url}"
