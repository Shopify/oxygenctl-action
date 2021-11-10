#!/bin/sh

# Bail with exit code = 1 if anything fails
set -eou pipefail

if [[ -n "$INPUT_PATH" ]]; then
  cd "$INPUT_PATH"
fi

export OXYGEN_DEPLOYMENT_TOKEN="$INPUT_OXYGEN_DEPLOYMENT_TOKEN"
export OXYGEN_COMMIT_MESSAGE="$INPUT_COMMIT_MESSAGE"
export OXYGEN_COMMIT_TIMESTAMP="$INPUT_COMMIT_TIMESTAMP"

oxygenctl --version

# Temporarily ignoring that successful deploys result in 502s, that's why we || true
preview_url="$(
  oxygenctl deploy \
    --assets-dir "$INPUT_OXYGEN_ASSETS_DIR" \
    --worker-file "$INPUT_OXYGEN_WORKER_FILE" \
    --dms-address "$INPUT_OXYGEN_DMS_ADDRESS"
)"

# Hardcoded storefont name for now
echo "::set-output name=url::$preview_url"
