#!/bin/bash

set -eEo pipefail

# Minimal, fast-path installer entrypoint for reproducing failures with
# logging-focused debug settings.
export OMARCHY_DEBUG=${OMARCHY_DEBUG:-1}
export OMARCHY_PATH="$HOME/.local/share/omarchy"
export OMARCHY_INSTALL="$OMARCHY_PATH/install"
export OMARCHY_INSTALL_LOG_FILE="/var/log/omarchy-install.log"
export PATH="$OMARCHY_PATH/bin:$PATH"

source "$OMARCHY_INSTALL/helpers/all.sh"

# Keep the essential guards but skip the full config stack.
source "$OMARCHY_INSTALL/preflight/guard.sh"
source "$OMARCHY_INSTALL/preflight/begin.sh"

run_logged "$OMARCHY_INSTALL/preflight/show-env.sh"
run_logged "$OMARCHY_INSTALL/preflight/pacman.sh"

# Trim package scope to the base set to surface issues quickly.
run_logged "$OMARCHY_INSTALL/packaging/base.sh"

echo "Debug-lite run completed. Log: $OMARCHY_INSTALL_LOG_FILE"
if [[ -n ${OMARCHY_ARTIFACT_DIR:-} ]]; then
  echo "Artifacts: $OMARCHY_ARTIFACT_DIR"
fi

stop_install_log
