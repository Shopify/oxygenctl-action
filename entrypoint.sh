# Don't set -u before checking this input
if [[ -n "$INPUT_PATH" ]]; then
  cd "$INPUT_PATH"
fi

# Bail on first non-zero exist status, and bail any referenced variable is unset.
set -eu

export OXYGEN_DEPLOYMENT_TOKEN="$INPUT_OXYGEN_DEPLOYMENT_TOKEN"
export OXYGEN_COMMIT_MESSAGE="$INPUT_COMMIT_MESSAGE"
export OXYGEN_COMMIT_TIMESTAMP="$INPUT_COMMIT_TIMESTAMP"
export OXYGEN_BUILD_COMMAND="$INPUT_BUILD_COMMAND"
export OXYGEN_WORKFLOW_ID="${GITHUB_RUN_ID}_${GITHUB_RUN_ATTEMPT}"
export OXYGEN_WORKFLOW_ID="${GITHUB_RUN_ID}_${GITHUB_RUN_ATTEMPT}"
export OXYGEN_ENVIRONMENT_TAG="${GITHUB_REF#refs/heads/}"

oxygenctl_bin="$(dirname $0)/oxygenctl"

preview_url="$(
  $oxygenctl_bin deploy \
    --assets-dir="$INPUT_OXYGEN_CLIENT_DIR" \
    --worker-dir="$INPUT_OXYGEN_WORKER_DIR" \
    --health-check="$INPUT_OXYGEN_HEALTH_CHECK"
)"

echo "url=$preview_url" >> $GITHUB_OUTPUT
