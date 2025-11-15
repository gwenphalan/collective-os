echo "Update fastfetch config with new CollectiveOS logo"

collectiveos-refresh-config fastfetch/config.jsonc

mkdir -p ~/.config/collectiveos/branding
cp $COLLECTIVEOS_PATH/icon.txt ~/.config/collectiveos/branding/about.txt
