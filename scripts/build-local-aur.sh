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

pushd "$WORKDIR" >/dev/null
for pkg in "${packages[@]}"; do
  echo "==> Building $pkg"
  rm -rf "$pkg"

  if [[ -d "$OVERRIDES_DIR/$pkg" ]]; then
    echo "    → Using aur-overrides/$pkg"
    cp -a "$OVERRIDES_DIR/$pkg" "$pkg"
  else
    git clone "https://aur.archlinux.org/${pkg}.git"
  fi

  pushd "$pkg" >/dev/null
  makepkg --syncdeps --clean --force --noconfirm --needed
  mv ./*.pkg.tar.* "$PKGDEST/"
  popd >/dev/null
  rm -rf "$pkg"
done
popd >/dev/null

repo-add "$PKGDEST/collectiveos-aur.db.tar.gz" "$PKGDEST"/*.pkg.tar.*
