echo "Migrate to proper packages for localsend and asdcontrol"

if collectiveos-pkg-present localsend-bin; then
  collectiveos-pkg-drop localsend-bin
  collectiveos-pkg-add localsend
fi

if collectiveos-pkg-present asdcontrol-git; then
  collectiveos-pkg-drop asdcontrol-git
  collectiveos-pkg-add asdcontrol
fi
