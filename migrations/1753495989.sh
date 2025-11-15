echo "Allow updating of timezone by right-clicking on the clock (or running collectiveos-cmd-tzupdate)"

if collectiveos-cmd-missing tzupdate; then
  bash "$COLLECTIVEOS_PATH/install/config/timezones.sh"
  collectiveos-refresh-waybar
fi
