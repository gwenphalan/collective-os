#!/bin/bash

set -eEo pipefail

# Minimal, fast-path installer entrypoint for reproducing failures with
# logging-focused debug settings.
export OMARCHY_DEBUG=${OMARCHY_DEBUG:-1}

# Resolve paths safely even in minimal/chrooted environments
if [[ -n ${HOME:-} ]]; then
  export OMARCHY_PATH="${OMARCHY_PATH:-$HOME/.local/share/omarchy}"
else
  export OMARCHY_PATH="${OMARCHY_PATH:-/tmp/omarchy}"
fi
export OMARCHY_INSTALL="${OMARCHY_INSTALL:-$OMARCHY_PATH/install}"

if [[ -z ${OMARCHY_INSTALL_LOG_FILE:-} ]]; then
  default_log="/var/log/omarchy-install.log"
  if { [[ -d /var/log && -w /var/log ]] || [[ -e "$default_log" && -w "$default_log" ]]; }; then
    export OMARCHY_INSTALL_LOG_FILE="$default_log"
  else
    export OMARCHY_INSTALL_LOG_FILE="/tmp/omarchy-install.log"
  fi
fi

# Ensure log directory exists even if unwritable parent would fail silently
log_dir=$(dirname "$OMARCHY_INSTALL_LOG_FILE")
mkdir -p "$log_dir" 2>/dev/null || true

export PATH="$OMARCHY_PATH/bin:$PATH"

if [[ ! -d "$OMARCHY_INSTALL" ]]; then
  echo "Missing installer directory: $OMARCHY_INSTALL" >&2
  exit 1
fi

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
