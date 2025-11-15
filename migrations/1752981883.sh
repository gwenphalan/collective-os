echo "Replace wofi with walker as the default launcher"

if collectiveos-cmd-missing walker; then
  collectiveos-pkg-add walker-bin libqalculate

  collectiveos-pkg-drop wofi
  rm -rf ~/.config/wofi

  mkdir -p ~/.config/walker
  cp -r ~/.local/share/collectiveos/config/walker/* ~/.config/walker/
fi
