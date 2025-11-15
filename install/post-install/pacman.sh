# Configure pacman
sudo cp -f ~/.local/share/collectiveos/default/pacman/pacman.conf /etc/pacman.conf
sudo cp -f ~/.local/share/collectiveos/default/pacman/mirrorlist /etc/pacman.d/mirrorlist
sudo cp -f ~/.local/share/collectiveos/default/pacman/cachyos-mirrorlist /etc/pacman.d/cachyos-mirrorlist

if ! sudo pacman-key --recv-keys F3B607488DB35A47; then
  curl -fsSL https://mirror.cachyos.org/cachyos.gpg | sudo pacman-key --add -
fi
sudo pacman-key --lsign-key F3B607488DB35A47

if lspci -nn | grep -q "106b:180[12]"; then
  cat <<EOF | sudo tee -a /etc/pacman.conf >/dev/null

[arch-mact2]
Server = https://github.com/NoaHimesaka1873/arch-mact2-mirror/releases/download/release
SigLevel = Never
EOF
fi
