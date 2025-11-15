echo "Add right-click terminal action to waybar collectiveos menu icon"

WAYBAR_CONFIG="$HOME/.config/waybar/config.jsonc"

if [[ -f "$WAYBAR_CONFIG" ]] && ! grep -A5 '"custom/collectiveos"' "$WAYBAR_CONFIG" | grep -q '"on-click-right"'; then
  sed -i '/"on-click": "collectiveos-menu",/a\    "on-click-right": "collectiveos-launch-terminal",' "$WAYBAR_CONFIG"
  collectiveos-state set restart-waybar-required
fi
