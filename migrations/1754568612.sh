echo "Update Waybar config to fix path issue with update-available icon click"

if grep -q "alacritty --class CollectiveOS --title CollectiveOS -e collectiveos-update" ~/.config/waybar/config.jsonc; then
  sed -i 's|\("on-click": "alacritty --class CollectiveOS --title CollectiveOS -e \)collectiveos-update"|\1collectiveos-update"|' ~/.config/waybar/config.jsonc
  collectiveos-restart-waybar
fi
