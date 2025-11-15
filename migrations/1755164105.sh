echo "Switch to CollectiveOS Chromium for synchronized theme switching"

if collectiveos-cmd-present chromium; then
  set_theme_colors() {
    if [[ -f ~/.config/collectiveos/current/theme/chromium.theme ]]; then
      chromium --no-startup-window --set-theme-color="$(<~/.config/collectiveos/current/theme/chromium.theme)"
    else
      # Use a default, neutral grey if theme doesn't have a color
      chromium --no-startup-window --set-theme-color="28,32,39"
    fi
  }

  collectiveos-pkg-drop chromium
  collectiveos-pkg-add collectiveos-chromium

  if pgrep -x chromium; then
    if gum confirm "Chromium must be restarted. Ready?"; then
      pkill -x chromium
      set_theme_colors
    fi
  else
    set_theme_colors
  fi
fi
