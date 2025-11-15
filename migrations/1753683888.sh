echo "Adding CollectiveOS version info to fastfetch"
if ! grep -q "collectiveos" ~/.config/fastfetch/config.jsonc; then
  cp ~/.local/share/collectiveos/config/fastfetch/config.jsonc ~/.config/fastfetch/
fi

