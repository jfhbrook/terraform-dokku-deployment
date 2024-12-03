#!/usr/bin/env bash

set -euo pipefail

RESPONSE="$(echo '{"name":null,"url":null}' | jq --arg name "${name}" '.name = $name')"

cd "${directory}"

while read -r line; do
  REMOTE_NAME="$(echo "${line}" | cut -f 1 -w)"
  REMOTE_URL="$(echo "${line}" | cut -f 2 -w)"
  REMOTE_DIRECTION="$(echo "${line}" | cut -f 3 -w)"
  if [[ "${REMOTE_NAME}" == "${name}" ]] && [[ "${REMOTE_DIRECTION}" == "(push)" ]]; then
    echo "${RESPONSE}" | jq -cM --arg url "${REMOTE_URL}" '.url = $url'
    exit
  fi
done < <(git remote -v)

echo "${RESPONSE}"
