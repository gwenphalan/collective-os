echo "Start screensaver automatically after 1 minute and stop before locking"

if ! grep -q "collectiveos-launch-screensaver" ~/.config/hypr/hypridle.conf; then
  collectiveos-refresh-hypridle
  collectiveos-refresh-hyprlock
fi
