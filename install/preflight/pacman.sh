if [[ -n ${COLLECTIVEOS_ONLINE_INSTALL:-} ]]; then
  # Install build tools
  sudo pacman -S --needed --noconfirm base-devel

  # Configure pacman
  sudo cp -f ~/.local/share/collectiveos/default/pacman/pacman.conf /etc/pacman.conf
  sudo cp -f ~/.local/share/collectiveos/default/pacman/mirrorlist /etc/pacman.d/mirrorlist

  sudo pacman-key --recv-keys 40DFB630FF42BCFFB047046CF0134EE680CAC571 --keyserver keys.openpgp.org
  sudo pacman-key --lsign-key 40DFB630FF42BCFFB047046CF0134EE680CAC571

  curl -s https://repo.cider.sh/ARCH-GPG-KEY | sudo pacman-key --add -
  sudo pacman-key --lsign-key A0CD6B993438E22634450CDD2A236C3F42A61682

  sudo pacman -Sy
  sudo pacman -S --noconfirm --needed collectiveos-keyring


  # Refresh all repos
  sudo pacman -Syu --noconfirm
fi
