#!/usr/bin/env bash

set -euo pipefail

RESPONSE="$(echo '{"local_sha":null,"remote_sha":null}' | jq -cM \
  --arg remote "${remote}" \
  --arg branch "${branch}" \
  '.remote = $remote | .remote_branch = $branch')"

git fetch "${remote}" 1>/dev/null

LOCAL_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
LOCAL_SHA="$(git rev-parse HEAD)"
REMOTE_SHA="$(git rev-parse "${remote}/${branch}" 2>/dev/null || echo 'null')"

echo "${RESPONSE}" | jq -cM \
  --arg local_branch "${LOCAL_BRANCH}" \
  --arg local_sha "${LOCAL_SHA}" \
  --arg remote_sha "${REMOTE_SHA}" \
  '.local_branch = $local_branch | .local_sha = $local_sha | .remote_sha = $remote_sha'
