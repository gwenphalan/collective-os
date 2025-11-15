echo "Fix JetBrains font setting"

if [[ $(collectiveos-font-current) == JetBrains* ]]; then
  collectiveos-font-set "JetBrainsMono Nerd Font"
fi
