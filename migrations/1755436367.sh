echo "Add minimal starship prompt to terminal"

if collectiveos-cmd-missing starship; then
  collectiveos-pkg-add starship
  cp $COLLECTIVEOS_PATH/config/starship.toml ~/.config/starship.toml
fi
