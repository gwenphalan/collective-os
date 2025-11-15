echo "Make new Osaka Jade theme available as new default"

if [[ ! -L ~/.config/collectiveos/themes/osaka-jade ]]; then
  rm -rf ~/.config/collectiveos/themes/osaka-jade
  git -C ~/.local/share/collectiveos checkout -f themes/osaka-jade
  ln -nfs ~/.local/share/collectiveos/themes/osaka-jade ~/.config/collectiveos/themes/osaka-jade
fi
