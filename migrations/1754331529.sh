echo "Update Waybar for new CollectiveOS menu"

if ! grep -q "" ~/.config/waybar/config.jsonc; then
  collectiveos-refresh-waybar
fi
