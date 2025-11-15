echo "Add the new Flexoki Light theme"

if [[ ! -L ~/.config/collectiveos/themes/flexoki-light ]]; then
  ln -nfs ~/.local/share/collectiveos/themes/flexoki-light ~/.config/collectiveos/themes/
fi
