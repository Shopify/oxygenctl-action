# Don't set -u before checking this input
if [[ -n "$INPUT_PATH" ]]; then
  cd "$INPUT_PATH"
fi

# Bail on first non-zero exist status, and bail any referenced variable is unset.
set -eu 

export OXYGEN_DEPLOYMENT_TOKEN="$INPUT_OXYGEN_DEPLOYMENT_TOKEN"
export OXYGEN_COMMIT_MESSAGE="$INPUT_COMMIT_MESSAGE"
export OXYGEN_COMMIT_TIMESTAMP="$INPUT_COMMIT_TIMESTAMP"
export OXYGEN_WORKFLOW_ID="$INPUT_WORKFLOW_RUN_ID"
export OXYGEN_SHOP_ID="$INPUT_SHOP_ID"
export OXYGEN_STOREFRONT_ID="$INPUT_STOREFRONT_ID"
export OXYGEN_BUILD_COMMAND="$INPUT_BUILD_COMMAND"

curdir = $(dirname $0)

$curdir/oxygenctl --version

# Temporarily ignoring that successful deploys result in 502s, that's why we || true
preview_url="$(
  $curdir/oxygenctl deploy \
    --assets-dir "$INPUT_OXYGEN_CLIENT_DIR" \
    --worker-dir "$INPUT_OXYGEN_WORKER_DIR" \
    --dms-address "$INPUT_OXYGEN_DMS_ADDRESS"
)"

# Hardcoded storefont name for now
echo "::set-output name=url::$preview_url"
