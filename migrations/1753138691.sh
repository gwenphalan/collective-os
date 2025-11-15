echo "Install swayOSD to show volume status"

if collectiveos-cmd-missing swayosd-server; then
  collectiveos-pkg-add swayosd
  setsid uwsm-app -- swayosd-server &>/dev/null &
fi
