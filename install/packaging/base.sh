# Install all base packages
mapfile -t packages < <(grep -v '^#' "$COLLECTIVEOS_INSTALL/collectiveos-base.packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"
