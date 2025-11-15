echo "Replace volume control GUI with a TUI"

if collectiveos-cmd-missing wiremix; then
  collectiveos-pkg-add wiremix
  collectiveos-pkg-drop pavucontrol
  collectiveos-refresh-applications
  collectiveos-refresh-waybar
fi
