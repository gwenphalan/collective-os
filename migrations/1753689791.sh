echo "Add the new ristretto theme as an option"

if [[ ! -L ~/.config/collectiveos/themes/ristretto ]]; then
  ln -nfs ~/.local/share/collectiveos/themes/ristretto ~/.config/collectiveos/themes/
fi
