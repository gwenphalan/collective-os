clear_logo
if is_debug_mode; then
  echo "Installing..."
else
  gum style --foreground 3 --padding "1 0 0 $PADDING_LEFT" "Installing..."
fi
echo
start_install_log
