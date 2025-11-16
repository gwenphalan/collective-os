#!/usr/bin/env bash
set -euo pipefail

PKGLIST_FILE="${1:-install/collectiveos-aur.packages}"
REPO_ROOT="$(git rev-parse --show-toplevel)"

if [[ ! -f "$PKGLIST_FILE" ]]; then
  PKGLIST_FILE="$REPO_ROOT/$PKGLIST_FILE"
fi

if [[ ! -f "$PKGLIST_FILE" ]]; then
  echo "Package list not found: $PKGLIST_FILE" >&2
  exit 1
fi

mapfile -t packages < <(grep -Ev '^\s*(#|$)' "$PKGLIST_FILE")

if [[ ${#packages[@]} -eq 0 ]]; then
  echo "No AUR packages specified in $PKGLIST_FILE" >&2
  exit 0
fi

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

PKGDEST="$REPO_ROOT/repos/local-aur/x86_64"
mkdir -p "$PKGDEST"
OVERRIDES_DIR="$REPO_ROOT/aur-overrides"

sudo pacman -S --needed --noconfirm base-devel git

retry_git_clone() {
  local url="$1"
  local dest="$2"
  local attempts=3
  local delay=2

  for attempt in $(seq 1 "$attempts"); do
    if git clone "$url" "$dest"; then
      return 0
    fi

    echo "    clone failed (attempt ${attempt}/${attempts}), retrying in ${delay}s..." >&2
    if (( attempt == attempts )); then
      break
    fi

    sleep "$delay"
    delay=$((delay * 2))
  done

  return 1
}

pushd "$WORKDIR" >/dev/null
for pkg in "${packages[@]}"; do
  echo "==> Building $pkg"
  rm -rf "$pkg"

  if [[ -d "$OVERRIDES_DIR/$pkg" ]]; then
    echo "    → Using aur-overrides/$pkg"
    cp -a "$OVERRIDES_DIR/$pkg" "$pkg"
  else
    if ! retry_git_clone "https://aur.archlinux.org/${pkg}.git" "$pkg"; then
      echo "    !! Failed to clone ${pkg} after multiple attempts" >&2
      exit 1
    fi
  fi

  pushd "$pkg" >/dev/null
  makepkg --syncdeps --clean --force --noconfirm --needed
  mv ./*.pkg.tar.* "$PKGDEST/"
  popd >/dev/null
  rm -rf "$pkg"
done
popd >/dev/null

repo-add "$PKGDEST/collectiveos-aur.db.tar.gz" "$PKGDEST"/*.pkg.tar.*
