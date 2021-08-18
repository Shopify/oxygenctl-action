#!/bin/sh
set -eou pipefail

export OXYGEN_DEPLOYMENT_TOKEN="$INPUT_OXYGEN_DEPLOYMENT_TOKEN"

# Read store domain from Hydrogen configuration file
export OXYGEN_STORE_DOMAIN=$(sed -n "s/.*storeDomain.*'\(.*\)'.*/\1/p" shopify.config.js)
if [ -z $OXYGEN_STORE_DOMAIN ]
then
  echo "OXYGEN_STORE_DOMAIN cannot be empty"
  exit 1
fi

oxygenctl --version
oxygenctl deploy \
  --assets-dir "$INPUT_OXYGEN_ASSETS_DIR" \
  --worker-file "$INPUT_OXYGEN_WORKER_FILE" \
  --dms-address "$INPUT_OXYGEN_DMS_ADDRESS" \
  --store-domain "$OXYGEN_STORE_DOMAIN"

# Hardcoded storefont name for now
echo "::set-output name=url::https://"${GITHUB_SHA:0:12}"--oxygen-test-shop.myshopify.dev"
