#!/bin/sh -l
echo "VINCENT"
nvm --version
echo $NODE_BUILD_VERSION
build_command_filtered=$(echo $2 | sed 's/HYDROGEN_ASSET_BASE_URL=$OXYGEN_ASSET_BASE_URL //g')
oxygen-cli --buildCommand=$build_command_filtered --token=$3 --path=$4 --workerFolder=$5 --assetsFolder=$6 --verificationMaxDuration=$7 
