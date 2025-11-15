#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$COLLECTIVEOS_INSTALL/.." && pwd)"
"$REPO_ROOT/scripts/build-local-aur.sh"
