echo "Add CollectiveOS Package Repository"

collectiveos-refresh-pacman-mirrorlist

if ! grep -q "collectiveos" /etc/pacman.conf; then
  sudo sed -i '/^\[core\]/i [collectiveos]\nSigLevel = Optional TrustAll\nServer = https:\/\/pkgs.omarchy.org\/$arch\n' /etc/pacman.conf
  sudo systemctl restart systemd-timesyncd
  sudo pacman -Syu --noconfirm
fi
