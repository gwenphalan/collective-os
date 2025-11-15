echo "Use explicit timezone selector when right-clicking on clock"

sed -i 's/collectiveos-cmd-tzupdate/collectiveos-launch-floating-terminal-with-presentation collectiveos-tz-select/g' ~/.config/waybar/config.jsonc
