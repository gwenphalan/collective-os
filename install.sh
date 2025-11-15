#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define CollectiveOS locations
export COLLECTIVEOS_PATH="$HOME/.local/share/collectiveos"
export COLLECTIVEOS_INSTALL="$COLLECTIVEOS_PATH/install"
export COLLECTIVEOS_INSTALL_LOG_FILE="/var/log/collectiveos-install.log"
export PATH="$COLLECTIVEOS_PATH/bin:$PATH"

# Install
source "$COLLECTIVEOS_INSTALL/helpers/all.sh"
source "$COLLECTIVEOS_INSTALL/preflight/all.sh"
source "$COLLECTIVEOS_INSTALL/packaging/all.sh"
source "$COLLECTIVEOS_INSTALL/config/all.sh"
source "$COLLECTIVEOS_INSTALL/login/all.sh"
source "$COLLECTIVEOS_INSTALL/post-install/all.sh"
