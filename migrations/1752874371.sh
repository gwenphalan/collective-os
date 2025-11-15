echo "Add Catppuccin Latte light theme"

if [[ ! -L "~/.config/collectiveos/themes/catppuccin-latte" ]]; then
  ln -snf ~/.local/share/collectiveos/themes/catppuccin-latte ~/.config/collectiveos/themes/
fi
