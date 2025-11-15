echo "Add new CollectiveOS Menu icon to Waybar"

mkdir -p ~/.local/share/fonts
cp ~/.local/share/collectiveos/config/collectiveos.ttf ~/.local/share/fonts/
fc-cache
