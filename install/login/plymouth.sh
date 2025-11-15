if [ "$(plymouth-set-default-theme)" != "collectiveos" ]; then
  sudo cp -r "$HOME/.local/share/collectiveos/default/plymouth" /usr/share/plymouth/themes/collectiveos/
  sudo plymouth-set-default-theme collectiveos
fi
