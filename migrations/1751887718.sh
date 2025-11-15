echo "Install Impala as new wifi selection TUI"

if collectiveos-cmd-missing impala; then
  collectiveos-pkg-add impala
  collectiveos-refresh-waybar
fi
