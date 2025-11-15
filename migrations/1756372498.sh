echo "Add eza themeing"

mkdir -p ~/.config/eza

if [ -f ~/.config/collectiveos/current/theme/eza.yml ]; then
  ln -snf ~/.config/collectiveos/current/theme/eza.yml ~/.config/eza/theme.yml
fi

