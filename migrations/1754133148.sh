echo "Update Waybar CSS to dim unused workspaces"

if ! grep -q "#workspaces button\.empty" ~/.config/waybar/style.css; then
  collectiveos-refresh-config waybar/style.css
  collectiveos-restart-waybar
fi
