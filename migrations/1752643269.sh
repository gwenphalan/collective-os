echo "Add new matte black theme"

if [[ ! -L "~/.config/collectiveos/themes/matte-black" ]]; then
  ln -snf ~/.local/share/collectiveos/themes/matte-black ~/.config/collectiveos/themes/
fi
